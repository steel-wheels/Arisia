/**
 * @file	ALFramePathr.swift
 * @brief	Define ALFramePath class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import Foundation

public class ALFramePath
{
	private var mPath:		Array<String>
	private var mInstanceName:	String?
	private var mClassName:		String?

	public init(path pth: Array<String>, instanceName iname: String, className fname: String) {
		mPath		= pth
		mInstanceName	= iname
		mClassName	= fname
		if iname.isEmpty || fname.isEmpty {
			CNLog(logLevel: .error, message: "Invalid parameter", atFunction: #function, inFile: #file)
		}
	}

	private init() {
		mPath		= []
		mInstanceName	= nil
		mClassName	= nil
	}

	public static var empty: ALFramePath { get {
		return ALFramePath()
	}}

	public var path: Array<String> { get {
		return mPath
	}}

	public var instanceName: String? { get {
		return mInstanceName
	}}

	public var classeName: String? { get {
		return mClassName
	}}

	public var fullInstanceName: String { get {
		var names: Array<String> = mPath
		if let str = mInstanceName {
			names.append(str)
		}
		return names.joined(separator: "_")
	}}

	public var fullPathName: String { get {
		var names: Array<String> = mPath
		if let str = mInstanceName {
			names.append(str)
		}
		return names.joined(separator: ".")
	}}

	public var fullTypeName: String { get {
		var names: Array<String> = mPath
		if let str = mInstanceName {
			names.append(str)
		}
		if let str = mClassName {
			names.append(str)
		}
		return names.joined(separator: "_")
	}}

	public var description: String { get {
		let pathstr = mPath.joined(separator: ",")
		return "{[" + pathstr + "], \"" + (mInstanceName ?? "") + "\", \"" + (mClassName ?? "") + "\"}"
	}}

	public func childPath(childInstanceName inst: String, childClassName clsname: String) -> ALFramePath {
		var newpath  = mPath ;
		if let str = mInstanceName {
			newpath.append(str)
		}
		return ALFramePath(path: newpath, instanceName: inst, className: clsname)
	}
}

