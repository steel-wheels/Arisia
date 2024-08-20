/**
 * @file	ALScriptCompiler.swift
 * @brief	Define ALScriptCompiler class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Foundation

public class ALScriptCompiler
{
	private var mResource:	KEResource
	private var mConfig: 	ALConfig

	public init(resource res: KEResource, config conf: ALConfig){
		mResource	= res
		mConfig		= conf
	}

	public func compile(rootFrame frame: ALFrameIR, language lang: ALLanguage) -> Result<CNTextSection, NSError> {
		let analyzer = ALScriptAnalyzer(resource: mResource, config: mConfig)
		if let err = analyzer.anayze(frame: frame) {
			return .failure(err)
		}

		let result = CNTextSection()
		switch transpile(frame: frame, language: lang) {
		case .success(let csect):
			result.add(text: csect)
			switch link(frame: frame) {
			case .success(let lsect):
				result.add(text: lsect)
				switch construct(frame: frame) {
				case .success(let csect):
					result.add(text: csect)
					return .success(result)
				case .failure(let err):
					return .failure(err)
				}
			case .failure(let err):
				return .failure(err)
			}
		case .failure(let err):
			return .failure(err)
		}
	}

	private func transpile(frame frm: ALFrameIR, language lang: ALLanguage) -> Result<CNTextSection, NSError> {
		let transpiler = ALScriptTranspiler(resource: mResource, config: mConfig)
		return transpiler.transpile(frame: frm, language: lang)
	}

	private func link(frame frm: ALFrameIR) -> Result<CNTextSection, NSError> {
		let linker = ALScriptLinker(config: mConfig)
		return linker.link(frame: frm)
	}

	private func construct(frame frm: ALFrameIR) -> Result<CNTextSection, NSError> {
		let constructor = ALScriptConstructor(config: mConfig)
		return constructor.construct(frame: frm)
	}

	private func compileError(message msg: String) -> NSError {
		return NSError.parseError(message: msg)
	}
}

