/**
 * @file AMLabel.swift
 * @brief	Define AMLabel class
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

public class AMLabel: KCLabelView, ALFrame
{
	public static let ClassName	= "Label"

	private static let TextItem	= "text"
	private static let NumberItem	= "number"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMLabel.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMLabel(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMLabel.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMLabel.TextItem,	type: .stringType),
				M(name: AMLabel.NumberItem,	type: .numberType)
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
		defineInterfaceType(interfaceType: AMLabel.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* text */
		if let str = stringValue(name: AMLabel.TextItem) {
			self.text = str
		} else {
			let _ = setStringValue(name: AMLabel.TextItem, value: self.text)
		}
		addObserver(propertyName: AMLabel.TextItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let str = param.toString() {
				CNExecuteInMainThread(doSync: false, execute: {
					self.text = str
				})
			}
		})

		/* number */
		if let num = numberValue(name: AMLabel.NumberItem) {
			self.number = num
		} else {
			let num = self.number ?? NSNumber(integerLiteral: 0)
			let _ = setNumberValue(name: AMLabel.NumberItem, value: num)
		}
		addObserver(propertyName: AMLabel.NumberItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let  num = param.toNumber() {
				CNExecuteInMainThread(doSync: false, execute: {
					self.number = num
				})
			}
		})

		return nil // noError
	}
}

