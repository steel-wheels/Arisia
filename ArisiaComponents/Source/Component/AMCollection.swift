/**
 * @file AMCollection.swift
 * @brief	Define AMCollection class
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
#if os(iOS)
import UIKit
#endif
import Foundation

public class AMCollection: KCCollectionView, ALFrame
{
	public static let ClassName = "Collection"

	private static let LoadItem         = "load"
    private static let CountItem        = "count"
	private static let PressedItem 		= "pressed"

	private var mContext:		KEContext
	private var mFrameCore:		ALFrameCore
	private var mPath:		    ALFramePath

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mContext	= ctxt
		mFrameCore	= ALFrameCore(frameName: AMCollection.ClassName, context: ctxt)
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
			(_ ctxt: KEContext) -> ALFrame in return AMCollection(context: ctxt)
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
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMCollection.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
            let itemtype: CNValueType
            if let itype = vmgr.searchInterfaceType(byTypeName: CNIcon.InterfaceName) {
                itemtype = .interfaceType(itype)
            } else {
                itemtype = .stringType
            }
			let baseif = ALDefaultFrame.baseInterfaceType
			let selfif = CNInterfaceType(name: ifname, base: nil, members: [])
			let ptypes: Array<M> = [
				M(name: AMCollection.CountItem,	        type: .numberType),
                M(name: AMCollection.LoadItem,	        type: .functionType(.arrayType(itemtype), [])),
				M(name: AMCollection.PressedItem,       type: .functionType(.voidType,
					[.interfaceType(selfif), .numberType])) // self, id-number
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
		defineInterfaceType(interfaceType: AMCollection.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

        /* count */
        /* execute after the collection is set */
        let count = super.numberOfItems(inSection: 0)
        setCount(count: count)

		/* pressed event */
		if self.value(name: AMCollection.PressedItem) == nil {
			/* pressed event is not implemented */
			self.setValue(name: AMCollection.PressedItem, value: JSValue(nullIn: self.mContext))
		}
		super.set(selectionCallback: {
			(_ idnum: Int) -> Void in
			if let evtval = self.value(name: AMCollection.PressedItem) {
				if !evtval.isNull {
					if let idval = JSValue(int32: Int32(idnum), in: self.mContext) {
						CNExecuteInUserThread(level: .event, execute: {
							evtval.call(withArguments: [self.mFrameCore, idval])	// insert self
						})
					}
				}
			}
		})

        /* load */
        if let ldfunc = self.value(name: AMCollection.LoadItem) {
            if let retval = ldfunc.call(withArguments: [self.mFrameCore]) {
                load(returnValue: retval)
            } else {
                CNLog(logLevel: .error, message: "No return value of load method", atFunction: #function, inFile: #file)
            }
        }

		return nil
	}

	private func setCollections(symbolNames snames: Array<String>, resource res: KEResource, console cons: CNFileConsole) {
		var items: Array<CNIcon> = []
		for sname in snames {
			if let sym = CNSymbol.decode(fromName: sname) {
                let item = CNIcon(tag: 0, symbol: sym, title: sym.identifier)
				items.append(item)
			} else {
				cons.print(string: "[Error] Unknown symbol name: \"\(sname)\" for collection component")

			}
		}
		if items.count > 0 {
			CNExecuteInMainThread(doSync: false, execute: {
				super.set(icons: items)
			})
		} else {
			cons.print(string: "[Error] No items for collection component")
		}
	}

    private func setCount(count cnt: Int) {
        if let numobj = JSValue(int32: Int32(cnt), in: mContext) {
            setValue(name: AMCollection.CountItem, value: numobj)
        } else {
            CNLog(logLevel: .error, message: "Failed to allocate count", atFunction: #function, inFile: #file)
        }
    }

    private func load(returnValue retval: JSValue) {
        guard let arr = retval.toArray() else {
            CNLog(logLevel: .error, message: "Failed to decode return value of load method", atFunction: #function, inFile: #file)
            return
        }
        guard arr.count > 0 else {
            return
        }
        var icons: Array<CNIcon> = []
        for elm in arr {
            if let obj = elm as? KLIcon {
                icons.append(obj.core)
            } else {
                CNLog(logLevel: .error, message: "Failed to decode load parameter of load method", atFunction: #function, inFile: #file)
            }
        }
        CNExecuteInMainThread(doSync: false, execute: {
            self.set(icons: icons)
        })
    }
}
