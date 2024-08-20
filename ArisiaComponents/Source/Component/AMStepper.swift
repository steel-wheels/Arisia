/**
 * @file AMStepper.swift
 * @brief	Define AMStepper  class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiLibrary
import KiwiEngine
import KiwiControls
import CoconutData
import JavaScriptCore
import Foundation

public class AMStepper: KCStepper, ALFrame
{
	public static let ClassName	= "Stepper"

	private static let InitValueItem	= "initValue"
	private static let MaxValueItem		= "maxValue"
	private static let MinValueItem		= "minValue"
	private static let StepValueItem	= "stepValue"
	private static let UpdatedItem		= "updated"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMStepper.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMStepper(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMStepper.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let selfif = CNInterfaceType(name: ifname, base: nil, members: [])
			let ptypes: Array<M> = [
				M(name: AMStepper.InitValueItem,	type: .numberType),
				M(name: AMStepper.MaxValueItem,		type: .numberType),
				M(name: AMStepper.MinValueItem,		type: .numberType),
				M(name: AMStepper.StepValueItem,	type: .numberType),
				M(name: AMStepper.UpdatedItem,		type: .functionType(.voidType,
									      [.interfaceType(selfif), .numberType]))
			]
			let newif = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	public func setup(path pth: ArisiaLibrary.ALFramePath, resource res: KiwiEngine.KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMStepper.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* minValue */
		if let minval = numberValue(name: AMStepper.MinValueItem) {
			self.minValue = minval.doubleValue
		} else {
			let minval = NSNumber(value: self.minValue)
			self.setNumberValue(name: AMStepper.MinValueItem, value: minval)
		}

		/* maxValue */
		if let maxval = numberValue(name: AMStepper.MaxValueItem) {
			self.maxValue = maxval.doubleValue
		} else {
			let maxval = NSNumber(value: self.maxValue)
			self.setNumberValue(name: AMStepper.MaxValueItem, value: maxval)
		}

		/* stepValue */
		if let stepval = numberValue(name: AMStepper.StepValueItem) {
			self.stepValue = stepval.doubleValue
		} else {
			let stepval = NSNumber(value: self.stepValue)
			self.setNumberValue(name: AMStepper.StepValueItem, value: stepval)
		}

		/* initValue */
		if let initval = numberValue(name: AMStepper.InitValueItem) {
			let val = initval.doubleValue
			self.currentValue = val
			self.triggerUpdatedEvent(value: val)
		} else {
			self.triggerUpdatedEvent(value: self.currentValue)
		}

		/* callback for currentValue event */
		self.updateValueCallback = {
			(_ newvalue: Double) -> Void in
			self.triggerUpdatedEvent(value: newvalue)
		}

		return nil // no error
	}

	private func triggerUpdatedEvent(value val: Double) {
		if let evtval = self.value(name: AMStepper.UpdatedItem) {
			let num = NSNumber(value: val)
			CNExecuteInUserThread(level: .event, execute: {
				evtval.call(withArguments: [self.mFrameCore, num])	// insert currentValue
			})
		}
	}
}

