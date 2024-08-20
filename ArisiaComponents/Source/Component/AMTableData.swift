/**
 * @file AMTableData.swift
 * @brief	Define AMTableData class
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

public class AMTableData: ALFrame
{
	public static let ClassName 		= "TableData"

	private static let NameItem		= "name"
        private static let TableItem            = "table"

        public struct SubInterfaceTypes {
                public var componentInterface:  CNInterfaceType
                public var tableInterface:      CNInterfaceType?
                public var recordInterface:     CNInterfaceType?

                public init(componentInterface: CNInterfaceType, tableInterface: CNInterfaceType?, recordInterface: CNInterfaceType?) {
                        self.componentInterface = componentInterface
                        self.tableInterface     = tableInterface
                        self.recordInterface    = recordInterface
                }
        }

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath
	private var mTable: 		CNTable?

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMTableData.ClassName, context: ctxt)
		mPath 		= ALFramePath.empty
		mTable		= nil

		mFrameCore.owner = self
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMTableData(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType> in
			let subif = self.subInterfaceType(path: path, frame: frm, resource: res)
                        var result: Array<CNInterfaceType> = []
                        if let recif = subif.recordInterface { result.append(recif) }
                        if let tblif = subif.tableInterface  { result.append(tblif) }
                        result.append(subif.componentInterface)
                        return result
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname  = ALFunctionInterface.defaultInterfaceName(frameName: AMTableData.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let baseif = ALDefaultFrame.baseInterfaceType

			/* correct interface members */
			let ptypes = AMTableData.baseInterfaceMembers()
			let newif  = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	private static func baseInterfaceMembers() -> Array<CNInterfaceType.Member> {
		typealias M = CNInterfaceType.Member
		let ptypes: Array<M> = [
			M(name: AMTableData.NameItem,		type: .stringType)
		]
		return ptypes
	}

	static public func subInterfaceType(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource) -> SubInterfaceTypes {
                let selfifname = AMTableData.userInterfaceName(path: fpath)
                let baseif = AMTableData.baseInterfaceType
                let selfif = CNInterfaceType(name: selfifname, base: baseif, members: [])
                if let subif = dbInterfaceType(frame: frm, resource: res) {
                        let ptypes = AMTableData.subInterfaceMembers(selfIF: selfif, tableIF: subif.tableInterface, recordIF: subif.recordInterface)
                        let result = CNInterfaceType(name: selfifname, base: baseif, members: ptypes)
                        return SubInterfaceTypes(componentInterface: result, tableInterface: subif.tableInterface, recordInterface: subif.recordInterface)
                } else {
                        let result = CNInterfaceType(name: selfifname, base: baseif, members: [])
                        return SubInterfaceTypes(componentInterface: result, tableInterface: nil, recordInterface: nil)
                }
	}

        private static func subInterfaceMembers(selfIF selfif: CNInterfaceType, tableIF tblif: CNInterfaceType, recordIF recif: CNInterfaceType) -> Array<CNInterfaceType.Member> {
		typealias M = CNInterfaceType.Member
		let ptypes: Array<M> = [
                        M(name: AMTableData.TableItem,		type: .interfaceType(tblif))
		]
		return ptypes
	}

        static private func dbInterfaceType(frame frm: ALFrameIR, resource res: KEResource) -> CNValueTable.SubInterfaceTypes? {
                guard let nameval = frm.property(name: NameItem) else {
                        CNLog(logLevel: .error, message: "Failed to get resource name for table",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                guard let tblname = nameval.value.toString() else {
                        CNLog(logLevel: .error, message: "The \(NameItem) property must have string",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                guard let table = res.table(identifier: tblname) else {
                        CNLog(logLevel: .error, message: "Failed to load table named: \(tblname)",
                              atFunction: #function, inFile: #file)
                        return nil
                }
                return CNValueTable.subInterfaceType(tableName: tblname, recordIf: table.recordType)
        }

        public static func userInterfaceName(path fpath: ALFramePath) -> String {
                return fpath.fullInstanceName + "_" + AMTableData.ClassName + "IF"
        }

	public func setup(path pth: ALFramePath, resource res: KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMTableData.baseInterfaceType)

		let selfifname = AMTableView.userInterfaceName(path: pth)
		let vmgr = CNValueTypeManager.shared
		if let iftype = vmgr.searchInterfaceType(byTypeName: selfifname) {
			defineInterfaceType(interfaceType: iftype)
		} else {
			CNLog(logLevel: .error, message: "Failed to get interface named: \(AMTableData.NameItem)", atFunction: #function, inFile: #file)
		}

		/* Set default properties */
		self.setupDefaulrProperties()

		/* name: .stringType */
		let name: String
		if let str = stringValue(name: AMTableData.NameItem) {
			name = str
		} else {
			name = "no_name"
			setStringValue(name: AMTableData.NameItem, value: name)
		}

		/* Load value table */
		let vtable: CNVirtualTable
		if let tbl = res.table(identifier: name) {
			vtable = CNVirtualTable(sourceTable: tbl)
		} else {
			/* Allocate dummy table */
			vtable = KCTableViewCore.allocateDummyTable()
		}
		mTable = vtable

                /* table item */
                let tblobj = KLTable(table: vtable, context: mContext)
                self.setValue(name: AMTableData.TableItem, value: JSValue(object: tblobj, in: mContext))

		return nil
	}
}
