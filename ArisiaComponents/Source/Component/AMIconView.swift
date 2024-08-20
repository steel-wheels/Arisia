/**
 * @file	AMIcon.swift
 * @brief	Define AMIcon class
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

public class AMIconView: KCIconView, ALFrame
{
	public static let ClassName		= "IconView"

	private static let PressedItem		= "pressed"
	private static let SymbolItem		= "symbol"
	private static let TitleItem		= "title"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMIconView.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMIconView(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMIconView.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMIconView.PressedItem,	type: .functionType(.voidType, [ .interfaceType(baseif) ])),
				M(name: AMIconView.SymbolItem,	type: .stringType),
				M(name: AMIconView.TitleItem,	type: .stringType)
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
		defineInterfaceType(interfaceType: AMIconView.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* New image */
		var newsym: CNSymbol? = nil

		/* symbol property */
		if let str = stringValue(name: AMIconView.SymbolItem) {
			if let sym = CNSymbol.decode(fromName: str) {
				newsym = sym
			} else {
				CNLog(logLevel: .error, message: "[Error] Unknown symbol name: \(str)")
			}
		}

		/* Assign dummy image */
		if newsym == nil {
			CNLog(logLevel: .error, message: "[Error] No symbol definition")
			newsym = .questionmark
		}

		/* Load image */
		if let sym = newsym {
			CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in self.symbol = sym
			})
		}

		/* title property */
		if let title = stringValue(name: AMIconView.TitleItem) {
			CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in self.title = title
			})
		} else {
			setStringValue(name: AMIconView.TitleItem, value: self.title)
		}
		addObserver(propertyName: AMIconView.TitleItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let title = param.toString() {
				CNExecuteInMainThread(doSync: false, execute: {
					self.title = title
				})
			}
		})

		/* "pressed" event */
		if self.value(name: AMIconView.PressedItem) == nil {
			self.setValue(name: AMIconView.PressedItem, value: JSValue(nullIn: core.context))
		}
		self.buttonPressedCallback = {
            (_ idx: Int) -> Void in
			if let evtval = self.value(name: AMIconView.PressedItem) {
				if !evtval.isNull {
					CNExecuteInUserThread(level: .event, execute: {
						evtval.call(withArguments: [self.mFrameCore])	// insert self
					})
				}
			}
		}

		return nil
	}
}

