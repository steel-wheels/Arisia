/**
 * @file AMTexEdott.swift
 * @brief	Define AMTexEditt class
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

public class AMTextEdit: KCTextEdit, ALFrame
{
	public static let ClassName 	= "TextEdit"

	private static let IsEditableItem	= "isEditable"
	private static let TerminalItem		= "terminal"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMTextEdit.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMTextEdit(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMTextEdit.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType
			let termif = searchInterface(name: CNEscapeCodes.InterfaceName)
			let ptypes: Array<M> = [
				M(name: AMTextEdit.IsEditableItem,	type: .boolType),
				M(name: AMTextEdit.TerminalItem,	type: .interfaceType(termif))
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
		defineInterfaceType(interfaceType: AMTextEdit.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* Terminal controller */
		let ctrlobj = KLTerminalController(controller: self.controller, context: mContext)
		self.setValue(name: AMTextEdit.TerminalItem, value: JSValue(object: ctrlobj, in: mContext))

		return nil // no error
	}
}

