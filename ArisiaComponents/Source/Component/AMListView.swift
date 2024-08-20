/**
 * @file AMListView.swift
 * @brief	Define AMListView class
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

public class AMListView: KCListView, ALFrame
{
	public static let ClassName		= "ListView"

	private static let ItemsItem		= "items"
	private static let IsEditableItem	= "isEditable"
	private static let SetItems		= "setItems"
	private static let SelectedItem		= "selectedItem"
	private static let UpdatedItem		= "updated"
	private static let VisibleRowCounts	= "visibleRowCounts"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMListView.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMListView(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMListView.ClassName)

		let vmgr   = CNValueTypeManager.shared
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMListView.IsEditableItem,	type: .boolType),
				M(name: AMListView.ItemsItem,		type: .functionType(.arrayType(.stringType),[])),
				M(name: AMListView.SetItems,     	type: .functionType(.voidType, [.arrayType(.stringType)])),
				M(name: AMListView.SelectedItem, 	type: .nullable(.stringType)),
				M(name: AMListView.UpdatedItem,		type: .numberType),
				M(name: AMListView.VisibleRowCounts,	type: .numberType)
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
		defineInterfaceType(interfaceType: AMListView.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* isEditable */
		if let val = self.booleanValue(name: AMListView.IsEditableItem) {
			self.isEditable = val
		} else {
			self.setBooleanValue(name: AMListView.IsEditableItem, value: self.isEditable)
		}
		addObserver(propertyName: AMListView.IsEditableItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if param.isBoolean {
				CNExecuteInMainThread(doSync: false, execute: {
					super.isEditable = param.toBool()
				})
			} else {
				CNLog(logLevel: .error, message: "Unexpected parameter for \(AMListView.IsEditableItem) property", atFunction: #function, inFile: #file)
			}
		})

		/* items */
		let itemsfunc: @convention(block) () -> JSValue = {
			() -> JSValue in return self.itemsToValue(items: super.items, context: self.core.context)
		}
		if let funcval = JSValue(object: itemsfunc, in: core.context) {
			setValue(name: AMListView.ItemsItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate function", atFunction: #function, inFile: #file)
		}

		/* selectedItem */
		if let item = super.selectedItem() {
			if let val = JSValue(object: item, in: self.core.context){
				setValue(name:  AMListView.SelectedItem, value: val)
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate value (0)", atFunction: #function, inFile: #file)
			}
		} else {
			if let nullval = JSValue(nullIn: self.core.context){
				setValue(name: AMListView.SelectedItem, value: nullval)
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate value (1)", atFunction: #function, inFile: #file)
			}
		}
		super.selectionNotification = {
			(_ str: String) -> Void in
			if let val = JSValue(object: str, in: self.core.context) {
				self.setValue(name: AMListView.SelectedItem, value: val)
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate value", atFunction: #function, inFile: #file)
			}
		}

		/* setMenus */
		let setitemsfunc: @convention(block) (_ param: JSValue) -> Void = {
			(_ param: JSValue) -> Void in
			if let items = self.valueToItems(value: param) {
				CNExecuteInMainThread(doSync: false, execute: {
					() -> Void in super.set(items: items)
				})
			} else {
				CNLog(logLevel: .error, message: "Failed to set list items", atFunction: #function, inFile: #file)
			}
		}
		if let funcval = JSValue(object: setitemsfunc, in: core.context) {
			setValue(name: AMListView.SetItems, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate function", atFunction: #function, inFile: #file)
		}

		/* visibleRowCounts */
		if let cnt = self.numberValue(name: AMListView.VisibleRowCounts) {
			super.visibleRowCount = cnt.intValue
		} else {
			let num = NSNumber(integerLiteral: super.visibleRowCount)
			self.setNumberValue(name: AMListView.VisibleRowCounts, value: num)
		}
		addObserver(propertyName: AMListView.VisibleRowCounts, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let num = param.toNumber() {
				CNExecuteInMainThread(doSync: false, execute: {
					super.visibleRowCount = num.intValue
				})
			}
		})

		/* updated */
		self.setNumberValue(name: AMListView.UpdatedItem, value: NSNumber(integerLiteral: 0))
		self.updatedNotification = { () -> Void in
			/* Update the counter */
			if let num = self.numberValue(name: AMListView.UpdatedItem) {
				let curval = num.intValue
				let nxtval: Int = curval < Int32.max ? curval + 1 : 1
				self.setNumberValue(name: AMListView.UpdatedItem, value: NSNumber(value: nxtval))
			}
		}

		return nil // noError
	}

	private func valueToItems(value val: JSValue) -> Array<String>? {
		if let arr = val.toArray() {
			return arr as? Array<String>
		} else {
			return nil
		}
	}

	private func itemsToValue(items itms: Array<String>, context ctxt: KEContext) -> JSValue {
		return JSValue(object: itms, in: ctxt)
	}
}


