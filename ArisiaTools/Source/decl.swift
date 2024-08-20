/**
 * @file	decl..swift
 * @brief	Define declaration functions
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaComponents
import ArisiaLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

private class Declarations {
        public var types:       Array<CNInterfaceType>
        public var members:     Dictionary<String, CNValueType>      // name member

        public init(types: Array<CNInterfaceType>, members: Dictionary<String, CNValueType> ) {
                self.types = types
                self.members = members
        }

        public convenience  init(types typs: Array<CNInterfaceType>, interfaceMembers membs: Array<CNInterfaceType.Member>) {
                var newmemb: Dictionary<String, CNValueType> = [:]
                for memb in membs {
                        newmemb[memb.name] = memb.type
                }
                self.init(types: typs, members: newmemb)
        }

        public func add(type typ: CNInterfaceType) {
                self.types.append(typ)
        }

        public func set(memberName nm: String, memberType typ: CNValueType) {
                self.members[nm] = typ
        }

        public func add(declaration decl: Declarations) {
                self.types.append(contentsOf: decl.types)
                for (name, type) in decl.members {
                        set(memberName: name, memberType: type)
                }
        }

        public func interfaceMembers() -> Array<CNInterfaceType.Member> {
                var result: Array<CNInterfaceType.Member> = []
                for name in self.members.keys.sorted() {
                        if let type = self.members[name] {
                                let memb = CNInterfaceType.Member(name: name, type: type)
                                result.append(memb)
                        }
                }
                return result
        }
}

public class TypeDeclGenerator
{
	private var mResource:		KEResource
	private var mConfig: 		ALConfig

	public init(resource res: KEResource, config conf: ALConfig){
		mResource	= res
		mConfig		= conf
	}

	public func generateFrameInterface(path pth: ALFramePath, frame frm: ALFrameIR) -> Result<Array<CNInterfaceType>, NSError> {
		var result: Array<CNInterfaceType> = []

		/* Generate declaration for current frame */
		switch generateOneFrameInterface(path: pth, frame: frm) {
		case .success(let iftypes):
			/* First, Generate declaration for child frames */
			for prop in frm.properties {
				switch prop.value {
				case .frame(let child):
					let cpath = pth.childPath(childInstanceName: prop.name, childClassName: child.className)
					switch generateFrameInterface(path: cpath, frame: child) {
					case .success(let iftypes):
						result.append(contentsOf: iftypes)
					case .failure(let err):
						return .failure(err)
					}
				default:
					break // nothing have to do
				}
			}
			/* The parent frame's declaration is placed after children */
                        result.append(contentsOf: iftypes)
		case .failure(let err):
			return .failure(err)
		}
		return .success(result)
	}

	private func generateOneFrameInterface(path fpath: ALFramePath, frame frm: ALFrameIR) -> Result<Array<CNInterfaceType>, NSError> {
                let result = Declarations(types: [], members: [:])

		/* base class of this frame */
		var basetype: CNInterfaceType
		switch TypeDeclGenerator.defaultInterfaceType(frameName: frm.className) {
		case .success(let typ):
			basetype = typ
		case .failure(let err):
			return .failure(err)
		}

		/* decide this class name */
		let selfname: String
		switch thisClassName(path: fpath, baseType: basetype, frame: frm) {
		case .success(let name):
			selfname = name
		case .failure(let err):
			return .failure(err)
		}

		/* collect properties  */
		for prop in frm.properties {
			if basetype.type(for: prop.name) == nil {
                                result.set(memberName: prop.name, memberType: prop.type)
			}
		}

		/* collect additional properties for subclasses */
		switch additionalPropertyTypes(path: fpath, frame: frm, resource: mResource) {
		case .success(let decl):
                        result.add(declaration: decl)
		case .failure(let err):
			return .failure(err)
		}

		/* adjust properties */
                for (pname, vtype) in result.members {
                        switch vtype {
                        case .functionType(_, _):
                                if let lfunc = getListnerFunction(frame: frm, propertyName: pname) {
                                        /* return type of listner function */
                                        result.set(memberName: pname, memberType: lfunc.returnType)
                                }
                        case .objectType(let cname):
                                let clsname  = cname ?? ALDefaultFrame.FrameName
                                let pathname = mergeNames(names: [fpath.fullInstanceName, pname, clsname])
                                let ifname   = ALFunctionInterface.defaultInterfaceName(frameName: pathname)
                                result.set(memberName: pname, memberType: .objectType(ifname))
                        default:
                                break
                        }
                }

                let newif = CNInterfaceType(name: selfname, base: basetype, members: result.interfaceMembers())
                var types = result.types ; types.append(newif)
                return .success(types)
	}

	private func thisClassName(path fpath: ALFramePath, baseType btype: CNInterfaceType, frame frm: ALFrameIR) -> Result<String, NSError> {
		let thisname: String
		switch frm.className {
		case AMTableData.ClassName:
            thisname = AMTableData.userInterfaceName(path: fpath)
		case AMTableView.ClassName:
            thisname = AMTableView.userInterfaceName(path: fpath)
		case AMProperties.ClassName:
			thisname = AMProperties.userInterfaceName(path: fpath)
		default:
			thisname =  mergeNames(names: [fpath.fullInstanceName, btype.name])
		}
		return .success(thisname)
	}

	private func mergeNames(names nms: Array<String>) -> String {
		let result: Array<String> = nms.filter{ !$0.isEmpty }
		return result.joined(separator: "_")
	}

	private func mergeMembers(source src: Array<CNInterfaceType.Member>, member addmemb: CNInterfaceType.Member) -> Array<CNInterfaceType.Member> {
		var result: Array<CNInterfaceType.Member> = []
		var added = false
		for srcmemb in src {
			if srcmemb.name == addmemb.name {
				let newmemb = CNInterfaceType.Member(name: srcmemb.name, type: addmemb.type)
				result.append(newmemb)
				added = true
			} else {
				result.append(srcmemb)
			}
		}
		if !added {
			result.append(addmemb)
		}
		return result
	}

	private func getListnerFunction(frame frm: ALFrameIR, propertyName pname: String) -> ALListnerFunctionIR? {
		if let prop = frm.property(name: pname) {
			switch prop.value {
			case .listnerFunction(let lfunc):
				return lfunc
			default:
				break
			}
		}
		return nil
	}

	public static func generateBaseDeclaration(frameName fname: String) -> Result<CNText, NSError> {
		/* Collect property types */
		switch defaultInterfaceType(frameName: fname) {
		case .success(let iftype):
			//return .success(generatePropertyDeclaration(interfaceType: iftype))
			return .success(iftype.toDeclaration(isInside: false))
		case .failure(let err):
			return .failure(err)
		}
	}

	private static func defaultInterfaceType(frameName fname: String) -> Result<CNInterfaceType, NSError> {
		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: fname)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return .success(iftype)
		} else {
			if let iftype = ALFrameManager.shared.baseInterface(forComponent: fname) {
				return .success(iftype)
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate", atFunction: #function, inFile: #file)
				return .failure(NSError.internalError(message: "Failed to allocate"))
			}
		}
	}

	private func additionalPropertyTypes(path pth: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> Result<Declarations, NSError> {
                let result = Declarations(types: [], members: [:])
		switch frm.className {
		case AMTableData.ClassName:
                        let iftype = AMTableData.subInterfaceType(path: pth, frame: frm, resource: res)
                        if let recif = iftype.recordInterface { result.add(type: recif) }
                        if let tblif = iftype.tableInterface  { result.add(type: tblif) }
                        result.add(type: iftype.componentInterface)
		case AMTableView.ClassName:
                        break
		case AMProperties.ClassName:
                        let iftype = AMProperties.subInterfaceType(path: pth, frame: frm, resource: res)
                        if let recif  = iftype.recordInterface     { result.add(type: recif)  }
                        result.add(type: iftype.componentInterface)
		default:
			break
		}
		return .success(result)
	 }

	private func valueToString(value valp: ALValueIR?) -> String? {
		if let val = valp {
			switch val {
			case .string(let str):
				return str
			default:
				break
			}
		}
		return nil
	}
}
