/**
 * @file AMTableView.swift
 * @brief	Define AMTableView class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

public class AMTableView: KCTableView, ALFrame
{
	public static let ClassName 		= "TableView"

	private static let Clickedtem		= "clicked"
	private static let ColumnCountItem	= "columnCount"
	private static let NameItem		    = "name"
	private static let RecordsItem		= "records"
	private static let RowCountItem		= "rowCount"
	private static let TableItem		= "table"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMTableView.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMTableView(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType> in
			return [subInterfaceType(path: path, frame: frm, resource: res)]
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname  = ALFunctionInterface.defaultInterfaceName(frameName: AMTableView.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType

			/* correct interface members */
			let ptypes = AMTableView.baseInterfaceMembers()
			let newif  = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	public static func baseInterfaceMembers() -> Array<CNInterfaceType.Member> {
		typealias M = CNInterfaceType.Member
		let ptypes: Array<M> = [
			M(name: AMTableView.ColumnCountItem,	type: .numberType),
			M(name: AMTableView.NameItem,		type: .stringType),
			M(name: AMTableView.RowCountItem,	type: .numberType)
		]
		return ptypes
	}

	static private func subInterfaceType(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> CNInterfaceType {
		let selfifname = AMTableView.userInterfaceName(path: fpath)

		let result: CNInterfaceType
		let vmgr = CNValueTypeManager.shared
		if let iftype = vmgr.searchInterfaceType(byTypeName: selfifname) {
			result = iftype
		} else {
			let baseif = AMTableView.baseInterfaceType
			let selfif = CNInterfaceType(name: selfifname, base: baseif, members: [])	// for forward declaration
			let recif  = allocateRecordIF(path: fpath, frame: frm, resource: res)
			let ptypes = AMTableView.subInterfaceMembers(selfIF: selfif, recordIF: recif)

			result = CNInterfaceType(name: selfifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: result)
		}
		return result
	}

	public static func subInterfaceMembers(selfIF selif: CNInterfaceType, recordIF recif: CNInterfaceType) -> Array<CNInterfaceType.Member> {
		typealias M = CNInterfaceType.Member
		let selfif: CNValueType = .interfaceType(selif)
		let ptypes: Array<M> = [
			M(name: AMTableView.RecordsItem,  type: .functionType(.arrayType(.interfaceType(recif)), [])),
			M(name: AMTableView.Clickedtem,	  type: .functionType(.voidType, [selfif, .boolType, .interfaceType(recif), .stringType])),
			M(name: AMTableView.TableItem, type: .interfaceType(selif))
		]
		return ptypes
	}

    public static func userInterfaceName(path fpath: ALFramePath) -> String {
        return fpath.fullInstanceName + "_" + AMTableView.ClassName + "IF"
    }

	private static func allocateRecordIF(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> CNInterfaceType {
		if let prop = frm.property(name: NameItem) {
			switch prop.value {
			case .string(let resname):
				if let table = res.table(identifier: resname) {
					let recif = table.recordType
					return recif
				} else {
					CNLog(logLevel: .error, message: "Failed to get record type for table: \(resname)",
					      atFunction: #function, inFile: #file)
				}
			default:
				CNLog(logLevel: .error, message: "Failed to get property named: \(NameItem)", atFunction: #function, inFile: #file)
			}
		}
		let recname = CNValueRecord.userInterfaceName(identifier: fpath.instanceName ?? "<undefined>")
		let recif   = CNInterfaceType(name: recname, base: nil, members: [])
		CNValueTypeManager.shared.add(interfaceType: recif)
		return recif
	}

	public func setup(path pth: ArisiaLibrary.ALFramePath, resource res: KiwiEngine.KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMTableView.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		/* name: .stringType */
		let name: String
		if let str = stringValue(name: AMTableView.NameItem) {
			name = str
		} else {
			name = "no_name"
			setStringValue(name: AMTableView.NameItem, value: name)
		}

		/* Load value table */
		let vtable: CNVirtualTable
		if let tbl = res.table(identifier: name) {
			vtable = CNVirtualTable(sourceTable: tbl)
		} else {
			/* Allocate dummy table */
			vtable = KCTableViewCore.allocateDummyTable()
		}
		super.dataTable = vtable

		/* records: .functionType(.arrayType(.interfaceType(recif)), [])) */
		let recsfunc: @convention(block) () -> JSValue = {
			() -> JSValue in return self.recordsFunc(in: super.dataTable)
		}
		if let funcval = JSValue(object: recsfunc, in: core.context) {
			setValue(name: AMTableView.RecordsItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMTableView.RecordsItem) function", atFunction: #function, inFile: #file)
		}

		/* clicked: M(name: .functionType(.voidType, [.boolType, .interfaceType(recif)]) */
		super.cellClickedCallback = {
			(_ double: Bool, _ record: CNRecord, _ field: String) -> Void in
			if let evtval = self.value(name: AMTableView.Clickedtem) {
				if !evtval.isNull {
					self.clickedFunc(eventFunc: evtval, double, record, field)
				}
			}
		}

		/* reload the table data */
		super.reload()

		return nil // no error
	}

	private func recordsFunc(in table: CNTable) -> JSValue {
		let ctxt = core.context
		var result: Array<JSValue> = []
		for rec in table.records() {
			let recobj = KLRecord(record: rec, context: ctxt)
			if let val = KLRecord.allocate(record: recobj) {
				result.append(val)
			}
		}
		return JSValue(object: result, in: ctxt)
	}

	private func clickedFunc(eventFunc efunc: JSValue, _ double: Bool, _ record: CNRecord, _ field: String) {
		CNExecuteInUserThread(level: .event, execute: {
			let ctxt   = self.core.context
			if let dblval = JSValue(bool: double, in: ctxt), let recval = JSValue(object: KLRecord(record: record, context: ctxt), in: ctxt), let fldval = JSValue(object: field, in: ctxt) {
				efunc.call(withArguments: [self.mFrameCore, dblval, recval, fldval])	// insert self
			}
		})
	}
}

