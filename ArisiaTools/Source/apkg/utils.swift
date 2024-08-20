/**
 * @file	utils..swift
 * @brief	Define utility functions
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Cobalt
import Foundation

public func replacePathExtension(fileName fname: String, to ext: String) -> String {
	let s0 = fname as NSString
	let s1 = s0.deletingPathExtension
	let s2 = s1.appending(ext)
	return s2 as String
}

public func identifier(from str: String) -> String {
	var result: String = ""
	var idx = str.startIndex
	let end = str.endIndex
	while idx < end {
		let c = str[idx]
		if c.isLetter || c.isNumber {
			result.append(c)
		} else {
			result.append("_")
		}
		idx = str.index(after: idx)
	}
	return result
}
