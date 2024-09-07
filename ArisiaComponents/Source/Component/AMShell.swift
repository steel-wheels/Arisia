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
			let ptypes: Array<M> = [
				M(name: AMShell.ConsoleItem,	type: consif)
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

		return nil
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
                if mShell == nil {
                        let sh = KHShell(application: .window, console: cons)
                        CNExecuteInUserThread(level: .thread, execute: {
                                () -> Void in sh.execute()
                        })
                        mShell = sh
                }
	}
}

