/**
 * @file	AMImage.swift
 * @brief	Define AMImage class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation
#if os(iOS)
import UIKit
#endif

public class AMImage: KCImageView, ALFrame
{
	public static let ClassName		= "Image"

	private static let NameItem 		= "name"
	private static let ScaleItem		= "scale"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMImage.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMImage(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath,_ frm: ALFrameIR,  _ res: KEResource) -> Array<CNInterfaceType> in
			return []
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMImage.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMImage.NameItem,	type: .stringType),
				M(name: AMImage.ScaleItem,	type: .numberType)
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
		defineInterfaceType(interfaceType: AMImage.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* name property */
		if let name = stringValue(name: AMImage.NameItem) {
			CNExecuteInMainThread(doSync: false, execute: {
				self.setImage(byName: name, resource: res, console: cons)
			})
		} else {
			cons.log(string: "[Error] \(AMImage.NameItem) property is required for Image component")
			self.setStringValue(name: AMImage.NameItem, value: "<no-name>")
		}
		addObserver(propertyName: AMImage.NameItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let name = param.toString() {
				CNExecuteInMainThread(doSync: false, execute: {
					self.setImage(byName: name, resource: res, console: cons)
				})
			}
		})

		/* scale */
		if let scale = numberValue(name: AMImage.ScaleItem) {
			self.scale = CGFloat(scale.doubleValue)
		} else {
			let num = NSNumber(floatLiteral: Double(self.scale))
			setNumberValue(name: AMImage.ScaleItem, value: num)
		}
		addObserver(propertyName: AMImage.ScaleItem, listnerFunction: {
			(_ param: Any) -> Void in
			if let scale = self.numberValue(name: AMImage.ScaleItem) {
				CNExecuteInMainThread(doSync: false, execute: {
					self.scale = CGFloat(scale.doubleValue)
				})
			} else {
				cons.log(string: "[Error] Invalid data type of \(AMImage.ScaleItem) parameter for Image component")
			}
		})

		return nil
	}

	private func setImage(byName name: String, resource res: KEResource, console cons: CNFileConsole) {
		if let img = res.image(identifier: name) {
            super.image = img
		} else {
			cons.error(string: "Failed to load image named: \(name)\n")
		}
	}
}

