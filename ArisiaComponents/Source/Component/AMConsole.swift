/**
 * @file AMConsole.swift
 * @brief	Define AMConsole class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiLibrary
import KiwiEngine
import KiwiControls
import CoconutData
import JavaScriptCore
import Foundation

public class AMConsole: KCConsoleView, ALFrame
{
	public static let ClassName	= "ConsoleView"

	private static let ErrorItem	= "error"
	private static let HeightItem	= "height"
	private static let ConsoleItem	= "console"
	private static let WidthItem	= "width"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMConsole.ClassName, context: ctxt)
		mPath		= ALFramePath.empty
		let frame	= CGRect(x: 0.0, y: 0.0, width: 188, height: 21)
		super.init(frame: frame)
		mFrameCore.owner = self
	}

	public required init?(coder: NSCoder) {
		fatalError("Not supported")
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMConsole(context: ctxt)
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

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared

		let consif: CNInterfaceType
		if let cif = vmgr.searchInterfaceType(byTypeName: CNDefaultConsole.InterfaceName) {
			consif = cif
		} else {
			CNLog(logLevel: .error, message: "Can not happen", atFunction: #function, inFile: #file)
			consif =  CNDefaultConsole.allocateInterfaceType()
		}

		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMConsole.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMConsole.ErrorItem,	type: .functionType(.voidType, [.stringType])),
				M(name: AMConsole.HeightItem,	type: .numberType),
				M(name: AMConsole.ConsoleItem,	type: .interfaceType(consif)),
				M(name: AMConsole.WidthItem,	type: .numberType)
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
		defineInterfaceType(interfaceType: AMConsole.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* console item */
		let consobj = KLConsole(context: mContext, console: super.console)
		setObjectValue(name: AMConsole.ConsoleItem, value: consobj)

		/* check size of terminal */
		let terminfo = super.terminalInfo
		var height   = terminfo.height
		var width    = terminfo.width
		var updated  = false

		/* height */
		if let num = numberValue(name: AMConsole.HeightItem) {
			if terminfo.height != num.intValue {
				height  = num.intValue
				updated = true
			}

		}
		/* width */
		if let num = numberValue(name: AMConsole.WidthItem) {
			if terminfo.width != num.intValue {
				width   = num.intValue
				updated = true
			}
		}
		if updated {
			//NSLog("Update size: \(width) x \(height)")
			super.controller.execute(escapeCodes: [.screenSize(width, height)])
		}

		return nil // noError
	}
}


