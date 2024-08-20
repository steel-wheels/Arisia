/**
 * @file AMTimer.swift
 * @brief	Define AMTimer class
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

public class AMTimer: ALFrame
{
	public static let ClassName = "Timer"

	private static let AddHandlerItem	= "addHandler"
	private static let IntervalItem		= "interval"
	private static let StartItem		= "start"
	private static let StopItem		= "stop"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath
	private var mTimer:		CNTimer

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMTimer.ClassName, context: ctxt)
		mPath 		= ALFramePath.empty
		mTimer		= CNTimer(interval: 1)
		mFrameCore.owner = self
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMTimer(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMTimer.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let hdlerif: CNValueType = .functionType(.boolType, [.numberType])

			let ptypes: Array<M> = [
				M(name: AMTimer.IntervalItem,	type: .numberType),
				M(name: AMTimer.StartItem,	type: .functionType(.voidType, [])),
				M(name: AMTimer.StopItem,	type: .functionType(.voidType, [])),
				M(name: AMTimer.AddHandlerItem,	type: .functionType(.boolType, [hdlerif]))
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
		defineInterfaceType(interfaceType: AMTimer.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* interval */
		if let interval = numberValue(name: AMTimer.IntervalItem) {
			mTimer.interval = interval.doubleValue
		} else {
			let interval = mTimer.interval
			self.setNumberValue(name: AMTimer.IntervalItem, value: NSNumber(value: interval))
		}
		addObserver(propertyName: AMTimer.IntervalItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let internum = param.toNumber() {
				self.mTimer.interval = internum.doubleValue
			} else {
				CNLog(logLevel: .error, message: "Invalid type for timer interval")
			}
		})

		/* start() */
		let startfunc: @convention(block) () -> Void = {
			() -> Void in CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in self.mTimer.start()
			})
		}
		if let funcval = JSValue(object: startfunc, in: core.context) {
			setValue(name: AMTimer.StartItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMTimer.StartItem) function", atFunction: #function, inFile: #file)
		}

		/* stop() */
		let stopfunc: @convention(block) () -> Void = {
			() -> Void in CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in self.mTimer.stop()
			})
		}
		if let funcval = JSValue(object: stopfunc, in: core.context) {
			setValue(name: AMTimer.StopItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMTimer.StopItem) function", atFunction: #function, inFile: #file)
		}

		/* addHandler() */
		let addhdlrfunc: @convention(block) (_ funcobj: JSValue) -> Void = {
			(_ funcobj: JSValue) -> Void in self.addHandler(funcobj: funcobj)
		}
		if let funcval = JSValue(object: addhdlrfunc, in: core.context) {
			setValue(name: AMTimer.AddHandlerItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMTimer.AddHandlerItem) function", atFunction: #function, inFile: #file)
		}

		return nil // no error
	}

	private func addHandler(funcobj funcval: JSValue) {
		mTimer.addTimerHandler(handler: {
			(_ repcnt: Int) -> Bool in
			guard let repval = JSValue(int32: Int32(repcnt), in: self.mContext) else {
				CNLog(logLevel: .error, message: "Failed to allocate parameter", atFunction: #function, inFile: #file)
				return false
			}
			/* Execute the callback function */
			guard let retval =  funcval.call(withArguments: [repval]) else {
				CNLog(logLevel: .error, message: "Return value is not exist", atFunction: #function, inFile: #file)
				return false
			}
			if retval.isBoolean {
				return retval.toBool()
			} else {
				CNLog(logLevel: .error, message: "Return value is not boolean", atFunction: #function, inFile: #file)
				return false
			}
		})
	}
}

