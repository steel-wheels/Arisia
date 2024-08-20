/**
 * @file AMProperties.swift
 * @brief	Define AMProperties class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

public class AMProperties: ALFrame
{
	public static let ClassName 		= "PropertiesData"

        public struct SubInterfaceTypes {
                public var componentInterface:  CNInterfaceType
                public var recordInterface:     CNInterfaceType?

                public init(componentInterface: CNInterfaceType, recordInterface: CNInterfaceType?) {
                        self.componentInterface = componentInterface
                        self.recordInterface = recordInterface
                }
        }

	private static let NameItem		= "name"
	private static let PropertiesItem	= "properties"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMProperties.ClassName, context: ctxt)
		mPath 		= ALFramePath.empty

		mFrameCore.owner = self
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMProperties(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType> in
			let subif = AMProperties.subInterfaceType(path: path, frame: frm, resource: res)
                        var result: Array<CNInterfaceType> = []
                        if let recif  = subif.recordInterface { result.append(recif) }
                        result.append(subif.componentInterface)
                        return result
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMProperties.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let ptypes: Array<M> = [
				M(name: AMProperties.NameItem,		type: .stringType)
			]
			let baseif = ALDefaultFrame.baseInterfaceType
			let newif  = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	static public func subInterfaceType(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> SubInterfaceTypes {
		let selfifname = AMProperties.userInterfaceName(path: fpath)
                let baseif = AMProperties.baseInterfaceType
                if let recif = readRecordInterfaceType(frame: frm, resource: res) {
                        let ptypes = subInterfaceMembers(recordIF: recif)
                        let result = CNInterfaceType(name: selfifname, base: baseif, members: ptypes)
                        return SubInterfaceTypes(componentInterface: result, recordInterface: recif)
                } else {
                        let result = CNInterfaceType(name: selfifname, base: baseif, members: [])
                        return SubInterfaceTypes(componentInterface: result, recordInterface: nil)
                }
	}

	private static func subInterfaceMembers(recordIF recif: CNInterfaceType) -> Array<CNInterfaceType.Member> {
                typealias M = CNInterfaceType.Member
                let ptypes: Array<M> = [
                        M(name: AMProperties.PropertiesItem,  type: .interfaceType(recif))
                ]
		return ptypes
	}

        static private func readRecordInterfaceType(frame frm: ALFrameIR, resource res: KEResource) -> CNInterfaceType? {
                guard let nameval = frm.property(name: NameItem) else {
                        CNLog(logLevel: .error, message: "Failed to get resource name for properties",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                guard let propname = nameval.value.toString() else {
                        CNLog(logLevel: .error, message: "The \(NameItem) property must have string",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                guard let props = res.properties(identifier: propname) else {
                        CNLog(logLevel: .error, message: "Failed to load properties named: \(propname)",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                return props.type
        }

        public static func userInterfaceName(path fpath: ALFramePath) -> String {
                return fpath.fullInstanceName + "_" + AMProperties.ClassName + "IF"
        }

	private static func allocateRecordIF(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> CNInterfaceType {
		if let prop = frm.property(name: NameItem) {
			switch prop.value {
			case .string(let resname):
				if let prop = res.properties(identifier: resname) {
					let recif = prop.type
					return recif
				} else {
					CNLog(logLevel: .error, message: "Failed to load property: \(resname)",
					      atFunction: #function, inFile: #file)
				}
			default:
				CNLog(logLevel: .error, message: "Invalid type of \(NameItem) property",
				      atFunction: #function, inFile: #file)
			}
		} else {
			CNLog(logLevel: .error, message: "Failed to get instance name for property",
			      atFunction: #function, inFile: #file)
		}
        let recname = CNValueRecord.userInterfaceName(identifier: fpath.instanceName ?? "<undefined>")
		let recif   = CNInterfaceType(name: recname, base: nil, members: [])
		CNValueTypeManager.shared.add(interfaceType: recif)
		return recif
	}

	public func setup(path pth: ALFramePath, resource res: KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMProperties.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* name */
		let propname: String
		if let nm = stringValue(name: AMProperties.NameItem) {
			propname      = nm
		} else {
			CNLog(logLevel: .error, message: "\"name\" property is required for PropertiesData component")
			propname      = "default"
		}

		/* Load properties */
		let props: CNProperties
		if let pres = res.properties(identifier: propname) {
			props       = pres
		} else {
			CNLog(logLevel: .error, message: "[Error] Failed to load properties", atFunction: #function, inFile: #file)
			let dummytype = CNInterfaceType(name: "_dummy_property", base: nil, members: [])
			props = CNValueProperties(type: dummytype)
		}

		/* properties */
		let propobj = KLProperties(properties: props, context: mContext)
		if let propval = KLProperties.allocate(properties: propobj) { // define property IF
			setValue(name: AMProperties.PropertiesItem, value: propval)
		} else {
			CNLog(logLevel: .error, message: "[Error] Failed to allocate properties object", atFunction: #function, inFile: #file)
		}

		return nil
	}

	private func stringArray(strings strs: Array<String>) -> JSValue {
		return JSValue(object: strs, in: mContext)
	}
}

