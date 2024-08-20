/**
 * @file	AMThread.swift
 * @brief	Define AMThread class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiEngine
import KiwiLibrary
import CoconutData
import JavaScriptCore
import Foundation

public class AMThread: KLScriptThread
{
	private var mViewController: AMComponentViewController

	public init(viewController vcont: AMComponentViewController, virtualMachine vm: JSVirtualMachine, scriptFile scr: URL, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) {
		mViewController = vcont
		super.init(scriptFile: scr, resource: res, virtualMachine: vm, console: cons, environment: env, config: conf)
	}

	public override func compile(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		ALFrameManager.shared.importBuiltinComponents()
		let compiler = AMLibraryCompiler(viewController: mViewController)
		return compiler.compile(context: ctxt, resource: res, console: cons, environment: env, config: conf)
	}
}

