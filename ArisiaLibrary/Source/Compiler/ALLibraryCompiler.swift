/**
 * @file	ALLibraryCompiler.swift
 * @brief	Define ALLibraryCompiler class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import KiwiLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

open class ALLibraryCompiler : KLLibraryCompiler
{
	public static let SetupComponentFuncName = "_setup_component"

	open override func compile(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		/* Compiler for KiwiKibrary */
		guard super.compile(context: ctxt, resource: res, console: cons, environment: env, config: conf) else {
			CNLog(logLevel: .error, message: "Failed to compile at KiwiLibrary", atFunction: #function, inFile: #file)
			return false
		}
		/* Commpile for this library */
		defineSetupComponentsFunction(context: ctxt, resource: res, console: cons, config: conf)
		defineConstructorFunctions(context: ctxt, console: cons)
		importBuiltinLibrary(context: ctxt, console: cons, config: conf)
		return true
	}

	private func defineSetupComponentsFunction(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, config conf: KEConfig) {
		let deffunc: @convention(block) (_ rootval: JSValue) -> JSValue = {
			(_ rootval: JSValue) -> JSValue in
			let result: Bool
			if let rootobj = rootval.toObject() as? ALFrameCore {
				if let core = rootobj.owner as? ALFrame {
					self.setup(frame: core, path:[], instanceName: ALConfig.rootInstanceName, resource: res, console: cons)
					result = true
				} else {
					CNLog(logLevel: .error, message: "Internal error", atFunction: #function, inFile: #file)
					result = false
				}
			} else {
				CNLog(logLevel: .error, message: "Unknown object", atFunction: #function, inFile: #file)
				result = false
			}
			return JSValue(bool: result, in: ctxt)
		}
		ctxt.set(name: ALLibraryCompiler.SetupComponentFuncName, function: deffunc)
	}

	private func setup(frame frm: ALFrame, path pth: Array<String>, instanceName iname: String, resource res: KEResource, console cons: CNFileConsole) {
		/* visit children */
		for pname in frm.propertyNames {
			if let val = frm.value(name: pname) {
				if val.isObject {
					if let child = val.toObject() as? ALFrameCore {
						if let cframe = child.owner as? ALFrame {
							var subpath = pth ; subpath.append(iname)
							setup(frame: cframe, path: subpath, instanceName: pname, resource: res, console: cons)
						}
					}
				}
			}
		}
		/* setup the frame */
		let newpath = ALFramePath(path: pth, instanceName: iname, className: frm.frameName)
		if let err = frm.setup(path: newpath, resource: res, console: cons) {
			CNLog(logLevel: .error, message: err.toString())
		}
	}

	private func defineConstructorFunctions(context ctxt: KEContext, console cons: CNFileConsole) {
		let fmanager = ALFrameManager.shared
		for clsname in fmanager.classNames {
			let allocfunc: @convention(block) () -> JSValue = {
				() -> JSValue in
				if let frame = fmanager.construct(forComponent: clsname, context: ctxt) {
					return JSValue(object: frame.core, in: ctxt)
				} else {
					cons.error(string: "Can not allocate frame: \(clsname)")
					return JSValue(nullIn: ctxt)
				}
			}
			ctxt.set(name: fmanager.constructorName(forComponent: clsname), function: allocfunc)
		}
	}

	private func importBuiltinLibrary(context ctxt: KEContext, console cons: CNConsole, config conf: KEConfig)
	{
		/* Contacts.js depends on the Process.js */
		let libnames = ["Transpiler"]
		do {
			for libname in libnames {
				if let url = CNFilePath.URLForResourceFile(fileName: libname, fileExtension: "js", subdirectory: "Library", forClass: ALLibraryCompiler.self) {
					let script = try String(contentsOf: url, encoding: .utf8)
					let _ = compileStatement(context: ctxt, statement: script, sourceFile: url, console: cons, config: conf)
				} else {
					cons.error(string: "Built-in script \"\(libname)\" is not found.")
				}
			}
		} catch {
			cons.error(string: "Failed to read built-in script in ArisiaLibrary")
		}
	}
}
