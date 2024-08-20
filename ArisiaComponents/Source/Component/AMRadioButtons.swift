/**
 * @file AMRadioButtons.swift
 * @brief	Define AMRadioButtons  class
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

public class AMRadioButtons: KCRadioButtons, ALFrame
{
	public static let ClassName	= "RadioButtons"

	private static let CurrentIndexItem	= "currentIndex"
	private static let ColumnNumItem	= "columnNum"
	private static let LabelsItem		= "labels"
	private static let SetEnableItem	= "setEnable"

	private static let NullIndex		= -1

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMRadioButtons.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMRadioButtons(context: ctxt)
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

		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMRadioButtons.ClassName)
		let vmgr   = CNValueTypeManager.shared
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMRadioButtons.CurrentIndexItem,	type: .numberType),
				M(name: AMRadioButtons.ColumnNumItem,		type: .numberType),
				M(name: AMRadioButtons.LabelsItem,		type: .arrayType(.stringType)),
				M(name: AMRadioButtons.SetEnableItem,		type: .functionType(.voidType, [.stringType, .boolType]))
			]
			let newif = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	static public var subInterfaceType: CNInterfaceType? { get {
		return nil
	}}

	public func setup(path pth: ALFramePath, resource res: KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMRadioButtons.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* labels */
		let labstrs: Array<String>
		if let labs = self.arrayValue(name: AMRadioButtons.LabelsItem) as? Array<String> {
			labstrs = labs
		} else {
			CNLog(logLevel: .error, message: "labels property is required (or must be corrected) for \(AMRadioButtons.ClassName) component")
			labstrs = ["radio_button"]
		}
		var labels: Array<KCRadioButtons.Label> = []
		for i in 0..<labstrs.count {
			labels.append(KCRadioButtons.Label(title: labstrs[i], id: i))
		}
		self.setLabels(labels: labels)

		/* currentIndex */
		let num = NSNumber(integerLiteral: self.currentIndex ?? AMRadioButtons.NullIndex )
		self.setNumberValue(name: AMRadioButtons.CurrentIndexItem, value: num)
		self.callback = {
			(_ labelid: Int?) -> Void in
			let lid = labelid ?? AMRadioButtons.NullIndex
			let num = NSNumber(integerLiteral: lid)
			self.setNumberValue(name: AMRadioButtons.CurrentIndexItem, value: num)
		}

		/* columnNum */
		if let num = self.numberValue(name: AMRadioButtons.ColumnNumItem) {
			self.columnNum = num.intValue
		} else {
			let num = NSNumber(integerLiteral: self.columnNum)
			self.setNumberValue(name: AMRadioButtons.ColumnNumItem, value: num)
		}

		return nil // no error
	}
}

