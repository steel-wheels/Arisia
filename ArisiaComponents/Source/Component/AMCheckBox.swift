/**
 * @file AMCheckBox.swift
 * @brief    Define AMCheckBox  class
 * @par Copyright
 *   Copyright (C) 2024 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiLibrary
import KiwiEngine
import KiwiControls
import CoconutData
import JavaScriptCore
import Foundation

public class AMCheckBox: KCCheckBox, ALFrame
{
    public static let ClassName         = "CheckBox"

    private static let LabelItem        = "label"
    private static let StatusItem       = "status"

    private var mContext:        KEContext
    private var mFrameCore:        ALFrameCore
    private var mPath:        ALFramePath

    public var core: ALFrameCore { get { return mFrameCore  }}
    public var path: ALFramePath { get { return mPath       }}

    public init(context ctxt: KEContext){
        mContext    = ctxt
        mFrameCore    = ALFrameCore(frameName: AMCheckBox.ClassName, context: ctxt)
        mPath        = ALFramePath.empty
        let frame    = CGRect(x: 0.0, y: 0.0, width: 188, height: 21)
        super.init(frame: frame)
        mFrameCore.owner = self
    }

    public required init?(coder: NSCoder) {
        fatalError("Not supported")
    }

    public static var constructor: ALFrameConstructor { get {
        let afunc: ALFrameConstructor.AllocateFunction = {
            (_ ctxt: KEContext) -> ALFrame in return AMCheckBox(context: ctxt)
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

        let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMCheckBox.ClassName)
        let vmgr   = CNValueTypeManager.shared
        if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
            return iftype
        } else {
            let baseif = ALDefaultFrame.baseInterfaceType
            let ptypes: Array<M> = [
                M(name: AMCheckBox.LabelItem,    type: .stringType),
                M(name: AMCheckBox.StatusItem,   type: .boolType)
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
        defineInterfaceType(interfaceType: AMCheckBox.baseInterfaceType)

        /* Set default properties */
        self.setupDefaulrProperties()

        /* label */
        if let label = self.stringValue(name: AMCheckBox.LabelItem) {
            super.title = label
        }
        addObserver(propertyName: AMCheckBox.LabelItem, listnerFunction: {
            (_ param: JSValue) -> Void in
            if let str = param.toString() {
                CNExecuteInMainThread(doSync: false, execute: {
                    self.title = str
                })
            }
        })

        /* Status */
        let stat = NSNumber(booleanLiteral: self.status)
        self.setNumberValue(name: AMCheckBox.StatusItem, value: stat)
        super.checkUpdatedCallback = {
            (_ newstat: Bool) -> Void in
            let newval = NSNumber(booleanLiteral: newstat)
            self.setNumberValue(name: AMCheckBox.StatusItem, value: newval)
        }

        return nil
    }
}
