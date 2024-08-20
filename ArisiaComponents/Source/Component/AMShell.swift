/**
 * @file AMShell.swift
 * @brief	Define AMShell class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiLibrary
import KiwiEngine
import KiwiShell
import CoconutData
import JavaScriptCore
import Foundation

public class AMShell: ALFrame
{
	public static let ClassName = "Shell"

	private static let ConsoleItem	= "console"
	private static let RunItem	= "run"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath
	private var mShell:		KHShell?

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	 = ctxt
		mFrameCore	 = ALFrameCore(frameName: AMShell.ClassName, context: ctxt)
		mPath 		 = ALFramePath.empty
		mShell		 = nil
		mFrameCore.owner = self
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMShell(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType> in
			return []
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static public var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMShell.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let consif: CNValueType
			if let cif = vmgr.search(byName: CNDefaultConsole.InterfaceName) {
				consif = cif
			} else {
				consif = .voidType
			}
			let urlif: CNValueType
			if let uif = vmgr.search(byName: URL.InterfaceName) {
				urlif = uif
			} else {
				CNLog(logLevel: .error, message: "No URL IF", atFunction: #function, inFile: #file)
				urlif = .voidType
			}
			let ptypes: Array<M> = [
				M(name: AMShell.ConsoleItem,	type: consif),
				M(name: AMShell.RunItem,	type: .functionType(.voidType, [urlif]))
			]
			let newif = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	public func setup(path pth: ALFramePath, resource res: KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMShell.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* console item */
		if let val = value(name: AMShell.ConsoleItem) {
			if let termcons = valueToConsole(value: val) {
				self.executeShell(console: termcons)
			}
		}
		addObserver(propertyName: AMShell.ConsoleItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let termcons = self.valueToConsole(value: param) {
				self.executeShell(console: termcons)
			}
		})

		/* run item */
		let runfunc: @convention(block) (_ urlval: JSValue) -> JSValue = {
			(_ urlval: JSValue) -> JSValue in
			return self.runFunction(url: urlval, resource: res, console: cons)
		}
		if let runval = JSValue(object: runfunc, in: mContext) {
			setValue(name: AMShell.RunItem, value: runval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMShell.RunItem) function", atFunction: #function, inFile: #file)
		}

		return nil
	}

	private func runFunction(url  urlval: JSValue, resource res: KEResource,console cons: CNFileConsole) -> JSValue {
		var result = false
		if let url = valueToURL(value: urlval) {
			if let shell = mShell {
				shell.run(scriptAt: url, resource: res, arguments: [])
				result = true
			}
		}
		if !result {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
		}
		return JSValue(bool: result, in: mContext)
	}

	private func valueToConsole(value val: JSValue) -> CNFileConsole? {
		if val.isObject {
			if let obj = val.toObject() as? KLConsole {
				return obj.console
			}
		}
		return nil
	}

	private func valueToURL(value val: JSValue) -> URL? {
		if val.isObject {
			if let obj = val.toObject() as? KLURL {
				return obj.url
			}
		}
		return nil
	}

	private func executeShell(console cons: CNFileConsole) {
		let shell: KHShell
		if let sh = mShell {
			shell = sh
		} else {
			let sh = KHShell(application: .window, console: cons)
			mShell = sh
			shell  = sh
		}
		if !shell.isRunning {
			CNExecuteInUserThread(level: .thread, execute: {
				() -> Void in shell.execute()
			})
		}
	}
}

