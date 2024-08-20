/**
 * @file AMTextField.swift
 * @brief	Define AMTextField class
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

public class AMTextField: KCTextField, ALFrame
{
	public static let ClassName 			= "TextField"

	private static let HasBackgroundColorItem	= "hasBackgroundColor"
	private static let IsEditableItem		= "isEditable"
	private static let TextItem			= "text"
	private static let NumberItem			= "number"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMTextField.ClassName, context: ctxt)
		mPath 		= ALFramePath.empty
		let frame	= CGRect(x: 0.0, y: 0.0, width: 188, height: 21)
		super.init(frame: frame)
		mFrameCore.owner = self
	}

	public required init?(coder: NSCoder) {
		fatalError("Not supported")
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMTextField(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMTextField.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				M(name: AMTextField.IsEditableItem,	type: .boolType),
				M(name: AMTextField.TextItem,		type: .stringType),
				M(name: AMTextField.NumberItem,		type: .numberType),
				M(name: AMTextField.HasBackgroundColorItem,	type: .boolType)
			]
			let newif = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	static private func searchInterface(name nm: String) -> CNInterfaceType {
		let vmgr   = CNValueTypeManager.shared
		if let ifv = vmgr.searchInterfaceType(byTypeName: nm) {
			return ifv
		} else {
			CNLog(logLevel: .error, message: "Color interface is not defined: \(nm)", atFunction: #function, inFile: #file)
			return CNInterfaceType.nilType
		}
	}

	public func setup(path pth: ArisiaLibrary.ALFramePath, resource res: KiwiEngine.KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMTextField.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* isEditable */
		if let val = value(name: AMTextField.IsEditableItem) {
			if val.isBoolean {
				CNExecuteInMainThread(doSync: false, execute: {
					super.isEditable = val.toBool()
				})
			} else {
				CNLog(logLevel: .error, message: "\(AMTextField.IsEditableItem) must have boolean", atFunction: #function, inFile: #file)
			}
		} else {
			setValue(name: AMTextField.IsEditableItem, value: JSValue(bool: super.isEditable, in: mContext))
		}
		addObserver(propertyName: AMTextField.IsEditableItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if param.isBoolean {
				CNExecuteInMainThread(doSync: false, execute: {
					super.isEditable = param.toBool()
				})
			} else {
				CNLog(logLevel: .error, message: "Invalid type for new index")
			}
		})

		/* text */
		if let val = value(name: AMTextField.TextItem) {
			if val.isString {
				CNExecuteInMainThread(doSync: false, execute: {
					super.text = val.toString()
				})
			} else {
				CNLog(logLevel: .error, message: "\(AMTextField.TextItem) must have string", atFunction: #function, inFile: #file)
			}
		} else {
			setValue(name: AMTextField.TextItem, value: JSValue(object: super.text, in: mContext))
		}
		addObserver(propertyName: AMTextField.TextItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if param.isString {
				CNExecuteInMainThread(doSync: false, execute: {
					super.text = param.toString()
				})
			} else {
				CNLog(logLevel: .error, message: "Invalid type for new index")
			}
		})
                /* callback from text field control */
                super.callbackFunction = {
                        (_ str: String) -> Void in
                        self.setValue(name: AMTextField.TextItem, value: JSValue(object: str, in: self.mContext))
                }

		/* number */
		if let val = value(name: AMTextField.NumberItem) {
			if val.isNumber {
				CNExecuteInMainThread(doSync: false, execute: {
					super.number = val.toNumber()
				})
			} else {
				CNLog(logLevel: .error, message: "\(AMTextField.NumberItem) must have number", atFunction: #function, inFile: #file)
			}
		} else {
			setValue(name: AMTextField.NumberItem, value: JSValue(object: super.number, in: mContext))
		}
		addObserver(propertyName: AMTextField.NumberItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if param.isNumber {
				CNExecuteInMainThread(doSync: false, execute: {
					super.number = param.toNumber()
				})
			} else {
				CNLog(logLevel: .error, message: "Invalid type for \(AMTextField.NumberItem) property")
			}
		})

		/* HasBackgroundColor */
		if let val = value(name: AMTextField.HasBackgroundColorItem) {
			if val.isBoolean {
				CNExecuteInMainThread(doSync: false, execute: {
					super.hasBackgrooundColor = val.toBool()
				})
			} else {
				CNLog(logLevel: .error, message: "\(AMTextField.HasBackgroundColorItem) must have boolean", atFunction: #function, inFile: #file)
			}
		} else {
			setValue(name: AMTextField.HasBackgroundColorItem, value: JSValue(bool: super.hasBackgrooundColor, in: mContext))
		}
		addObserver(propertyName: AMTextField.HasBackgroundColorItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if param.isBoolean {
				CNExecuteInMainThread(doSync: false, execute: {
					super.hasBackgrooundColor = param.toBool()
				})
			} else {
				CNLog(logLevel: .error, message: "Invalid type for \(AMTextField.HasBackgroundColorItem) property")
			}
		})

		return nil // no error
	}
}

