/**
 * @file	ALFrameManager.swift
 * @brief	Define ALFrameManager class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Foundation

public class ALFrameManager
{
	private static var mShared: ALFrameManager? = nil

	public static var shared: ALFrameManager { get {
		if let obj = mShared {
			return obj
		} else {
			let newobj = ALFrameManager()
			mShared = newobj
			return newobj
		}
	}}

	private var mAllocators: Dictionary<String, ALFrameConstructor>

	private init(){
		mAllocators = [ALDefaultFrame.FrameName: ALDefaultFrame.constructor]
	}

	public var classNames: Array<String> { get { return Array(mAllocators.keys.sorted()) }}

	public func hasAllocator(className name: String) -> Bool {
		if let _ = mAllocators[name] {
			return true
		} else {
			return false
		}
	}

	public func addAllocator(className name: String, constructor cnst: ALFrameConstructor){
		mAllocators[name] = cnst
	}

	public func baseInterface(forComponent comp: String) -> CNInterfaceType? {
		if let alloc = mAllocators[comp] {
			return alloc.baseInterface()
		} else {
			return nil
		}
	}

	public func subInterface(path fpath: ALFramePath, frame frm: ALFrameIR, resource res: KEResource, forComponent comp: String) -> Array<CNInterfaceType> {
		if let alloc = mAllocators[comp] {
			return alloc.subInterface(fpath, frm, res)
		} else {
			return []
		}
	}

	public func construct(forComponent comp: String, context ctxt: KEContext) -> ALFrame? {
		if let alloc = mAllocators[comp] {
			return alloc.allocate(ctxt)
		} else {
			return nil
		}
	}

	public func constructorName(forComponent comp: String) -> String {
		return "_alloc_" + comp
	}

	public func isFrameClassName(name nm: String) -> Bool {
		if let _ = mAllocators[nm] {
			return true
		} else {
			return false
		}
	}
}
