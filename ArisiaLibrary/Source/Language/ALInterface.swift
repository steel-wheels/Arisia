/**
 * @file	ALInterface.swift
 * @brief	Define ALFunctionInterface class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import CoconutData
import Foundation

public class ALFunctionInterface
{
	public static let FrameInterface	    = "FrameIF"
	public static let FrameCoreInterface	= "FrameCoreIF"

	public static func defaultInterfaceName(frameName name: String) -> String {
		return name + "IF"
	}

	public static func userInterfaceName(path fpath: ALFramePath) -> String {
		return defaultInterfaceName(frameName: fpath.fullTypeName)
	}

	public static func userInterfaceType(path fpath: ALFramePath) -> CNValueType  {
		return .objectType(userInterfaceName(path: fpath))
	}
}

extension CNValueTable
{
    public static func userInterfaceName(identifier ident: String) -> String {
        return ident + "_" + CNValueTable.InterfaceName
    }

    public static func userInterfaceFile(identifier ident: String) -> String {
        return ident + "-table-if"
    }
}

extension CNValueRecord
{
    public static func userInterfaceName(identifier ident: String) -> String {
        return ident + "_" + CNValueRecord.InterfaceName
    }

    public static func userInterfaceFile(identifier ident: String) -> String {
        return ident + "-record-if"
    }
}

