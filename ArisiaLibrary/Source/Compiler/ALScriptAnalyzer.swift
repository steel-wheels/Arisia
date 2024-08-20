/**
 * @file	ALScriptAnalyzer.swift
 * @brief	Define ALScriptAnalyzer class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Foundation

public class ALScriptAnalyzer: ALScriptLinkerBase
{
	private var mResource: KEResource

	public init(resource res: KEResource, config conf: ALConfig){
		mResource = res
		super.init(config: conf)
	}

	public func anayze(frame frm: ALFrameIR) -> NSError? {
		let path = ALFramePath(path: [], instanceName: ALConfig.rootInstanceName, className: frm.className)
		return analyze(path: path, frame: frm, rootFrame: frm)
	}

	private func analyze(path fpath: ALFramePath, frame frm: ALFrameIR, rootFrame root: ALFrameIR) -> NSError? {
		/* Set path info */
		frm.path = fpath

		for pname in frm.propertyNames {
			if let pval = frm.value(name: pname) {
				switch pval {
				case .frame(let child):
					/* Visit child frame */
					let cpath = fpath.childPath(childInstanceName: pname, childClassName: child.className)
					if let err = analyze(path: cpath, frame: child, rootFrame: root) {
						return err
					}
				case .initFunction(let ifunc):
					ifunc.owner = frm
				case .eventFunction(let efunc):
					efunc.owner = frm
				case .proceduralFunction(let pfunc):
					pfunc.owner = frm
				case .listnerFunction(let lfunc):
					lfunc.owner = frm
					let pstack = CNStack<String>()
					for path in fpath.path {
						pstack.push(path)
					}
					if let err = decideListnerParameterTypes(listnerName: pname, listnerFunction: lfunc, pathStack: pstack, rootFrame: root) {
						return err
					}
				case .bool(_), .number(_), .string(_), .array(_), .dictionary(_), .enumValue(_, _, _), .invokedFunction(_):
					break
				}
			}
		}
		return nil
	}

	private func decideListnerParameterTypes(listnerName lname: String, listnerFunction lfunc: ALListnerFunctionIR, pathStack pstack: CNStack<String>, rootFrame root: ALFrameIR) -> NSError? {
		for path in lfunc.pathArguments {
			switch pathToFullPath(pathExpression: path.pathExpression, pathStack: pstack, rootFrame: root) {
			case .success(let pathexp):
				switch pointedFrame(by: pathexp, rootFrame: root) {
				case .success(let owner):
					if let ptype = propertyType(owner: owner.frame, propertyName: owner.propertyName) {
						path.type = ptype
					} else {
						let pathstr = pathexp.description()
						return NSError.parseError(message: "No object named \"\(owner.propertyName)\" at \"\(pathstr)\"\n")
					}
				case .failure(let err):
					return err
				}
			case .failure(let err):
				return err
			}
		}
		return nil // no error
	}

	private func propertyType(owner own: ALFrameIR, propertyName pname: String) -> CNValueType? {
		if let prop = own.property(name: pname) {
			return prop.type
		}
		let fmanager = ALFrameManager.shared
		if let iftype = fmanager.baseInterface(forComponent: own.className) {
			if let member = iftype.member(for: pname) {
				return member.type
			}
		}
		let iftypes = fmanager.subInterface(path: own.path, frame: own, resource: mResource, forComponent: own.className)
                if let iftype = iftypes.last {
                        if let member = iftype.member(for: pname) {
                                return member.type
                        }
                }
                return nil // not found
	}

}

