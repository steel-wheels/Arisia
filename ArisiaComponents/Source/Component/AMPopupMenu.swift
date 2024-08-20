/**
 * @file AMPopupMenu.swift
 * @brief	Define AMPopupMenu class
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

public class AMPopupMenu: KCPopupMenu, ALFrame
{
	public static let ClassName	= "PopupMenu"

        private static let CurrentItem          = "current"
	private static let SetItem		= "set"
	private static let SelectedItem	        = "selected"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMPopupMenu.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMPopupMenu(context: ctxt)
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

		let labelif: CNValueType
		let vmgr     = CNValueTypeManager.shared
		if let labif = vmgr.searchInterfaceType(byTypeName: CNMenuItem.InterfaceName) {
			labelif = .interfaceType(labif)
		} else {
			CNLog(logLevel: .error, message: "\(CNMenuItem.InterfaceName) interface is NOT found", atFunction: #function, inFile: #file)
			labelif = .stringType
		}

		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMPopupMenu.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
                        let selfif = CNInterfaceType(name: ifname, base: nil, members: [])
			let ptypes: Array<M> = [
                                M(name: AMPopupMenu.CurrentItem,        type: .nullable(labelif)),
				M(name: AMPopupMenu.SetItem,            type: .functionType(.voidType, [.arrayType(labelif)])),
                                M(name: AMPopupMenu.SelectedItem,       type: .functionType(.voidType, [ .interfaceType(selfif), labelif])),
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
		defineInterfaceType(interfaceType: AMPopupMenu.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* selectedItem */
                super.selectionNotification = {
                        (_ idx: Int) -> Void in
                        let ctxt = self.core.context
                        if let item = super.menuItem(at: idx) {
                                let itemobj = KLMenuItem(menuItem: item, context: ctxt)
                                self.setValue(name: AMPopupMenu.CurrentItem, value: JSValue(object: itemobj, in: ctxt)) // current item
                                if let evtval = self.value(name: AMPopupMenu.SelectedItem) {
                                        CNExecuteInUserThread(level: .event, execute: {
                                                evtval.call(withArguments: [self.mFrameCore, itemobj])        // insert self, menu-item
                                        })
                                } else {
                                        CNLog(logLevel: .error, message: "Failed to allocate value", atFunction: #function, inFile: #file)
                                }
                        }
                }

		/* setMenus */
		let setmenusfunc: @convention(block) (_ param: JSValue) -> Void = {
			(_ param: JSValue) -> Void in
                        var items: Array<CNMenuItem> = []
                        if let arr = param.toArray() {
                                for elm in arr {
                                        if let obj = elm as? KLMenuItem {
                                                items.append(obj.core())
                                        } else {
                                                CNLog(logLevel: .error, message: "The parameter of setMenus must have array of MenuItem")
                                        }
                                }
                        } else {
                                CNLog(logLevel: .error, message: "The parameter of setMenus must have array of MenuItem")
                        }
			CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in super.set(menuItems: items)
			})
		}
		if let funcval = JSValue(object: setmenusfunc, in: core.context) {
			setValue(name: AMPopupMenu.SetItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate function", atFunction: #function, inFile: #file)
		}

                /* current */
                setValue(name: AMPopupMenu.CurrentItem, value: JSValue(nullIn: core.context))

		/* selectByValue */ /*
		let selbyvalfunc: @convention(block) (_ param: JSValue) -> JSValue = {
			(_ param: JSValue) -> JSValue in
			let ctxt = self.core.context
			if param.isNumber {
				let val = param.toNumber().intValue
				var result = false
				CNExecuteInMainThread(doSync: true, execute: {
					() -> Void in result = super.select(byValue: val)
				})
				return JSValue(bool: result, in: ctxt)
			} else {
				return JSValue(bool: false, in: ctxt)
			}
		}
		if let funcval = JSValue(object: selbyvalfunc, in: core.context) {
			setValue(name: AMPopupMenu.SelectByValue, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate function", atFunction: #function, inFile: #file)
		}*/

		return nil // noError
	}
}


