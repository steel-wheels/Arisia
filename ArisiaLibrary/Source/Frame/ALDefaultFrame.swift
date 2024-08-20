/**
 * @file	ALDefaultFrame.swift
 * @brief	Define ALDefaultFrame class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import JavaScriptCore

@objc public class ALDefaultFrame: NSObject, ALFrame
{
	public static let FrameName = "Frame"

	private var mFrameCore:	ALFrameCore
	private var mPath:	ALFramePath

	public var core: ALFrameCore { get { return mFrameCore	}}
	public var path: ALFramePath { get { return mPath	}}

	public init(frameName cname: String, context ctxt: KEContext){
		mFrameCore = ALFrameCore(frameName: cname, context: ctxt)
		mPath      = ALFramePath.empty
		super.init()

		mFrameCore.owner = self
	}

	static public var constructor: ALFrameConstructor { get {
		let alloc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in
			return ALDefaultFrame(frameName: FrameName, context: ctxt)
		}
		let baseif: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in
			return ALDefaultFrame.baseInterfaceType
		}
		let subif: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType>
                        in return []
		}

		return ALFrameConstructor(frameName: FrameName, allocaFunc: alloc, baseInterfaceFunction: baseif, subInterfaceFunction: subif)
	}}

	static public var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: ALDefaultFrame.FrameName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let ptypes: Array<CNInterfaceType.Member> = [
				M(name: ALFrameCore.FrameNameItem,	type: .stringType),
				M(name: ALFrameCore.PropertyNamesItem,	type: .arrayType(.stringType))
			]
			let iftype = CNInterfaceType(name: ifname, base: nil, members: ptypes)
			vmgr.add(interfaceType: iftype)
			return iftype
		}
	}}

	public func setup(path pth: ALFramePath, resource res: KEResource, console cons: CNFileConsole) -> NSError? {
		mPath = pth
		self.setupDefaulrProperties()
		return nil
	}
}

