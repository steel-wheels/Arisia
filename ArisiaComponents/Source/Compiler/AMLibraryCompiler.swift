/**
 * @file	KMLibraryCompiler.swift
 * @brief	Define KMLibraryCompiler class
 * @par Copyright
 *   Copyright (C) 2020 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiEngine
import KiwiLibrary
import CoconutData
import JavaScriptCore
import UniformTypeIdentifiers

open class AMLibraryCompiler: ALLibraryCompiler
{
	private var mViewController: AMComponentViewController?

	public init(viewController vcont: AMComponentViewController?) {
		mViewController = vcont
	}

	open override func compile(context ctxt: KEContext, resource res: KEResource, console cons: CNFileConsole, environment env: CNEnvironment, config conf: KEConfig) -> Bool {
		ALFrameManager.shared.importBuiltinComponents()

		guard super.compile(context: ctxt, resource: res, console: cons, environment: env, config: conf) else {
			return false
		}

		/* Define functions for built-in components */
		if let vcont = mViewController {
			defineComponentFuntion(context: ctxt, viewController: vcont, resource: res)
			defineBuiltinFuntion(context: ctxt, viewController: vcont, resource: res, environment: env, config: conf)
		} else {
			NSLog("Failed to compile (1)")
		}

		importBuiltinLibrary(context: ctxt, console: cons, config: conf)

		return true
	}

	private func defineComponentFuntion(context ctxt: KEContext, viewController vcont: AMComponentViewController, resource res: KEResource) {
		/* enterView function */
		let enterfunc: @convention(block) (_ pathval: JSValue, _ argval: JSValue, _ cbfunc: JSValue) -> Void = {
			(_ paramval: JSValue, _ argval: JSValue, _ cbfunc: JSValue) -> Void in
			CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in
				if let vname = self.parameterToViewName(parameter: paramval) {
					let conv = KLScriptValueToNativeValue()
					let arg  = conv.convert(scriptValue: argval)
					self.enterView(viewController: vcont, context: ctxt, viewName: vname, argument: arg, resource: res, callback: cbfunc)
				}
			})
		}
		ctxt.set(name: "_enterView", function: enterfunc)

		/* leaveView function */
		let leavefunc: @convention(block) (_ retval: JSValue) -> Void = {
			(_ retval: JSValue) -> Void in
			let conv = KLScriptValueToNativeValue()
			let nval = conv.convert(scriptValue: retval)
			self.leaveView(viewController: vcont, returnValue: nval)
		}
		ctxt.set(name: "leaveView", function: leavefunc)

		/* _alert */
		let alertfunc: @convention(block) (_ type: JSValue, _ msg: JSValue, _ labels: JSValue, _ cbfunc: JSValue) -> Void = {
			(_ type: JSValue, _ msg: JSValue, _ labels: JSValue, _ cbfunc: JSValue) -> Void in
            AMAlert.execute(type: type, message: msg, labels: labels, callback: cbfunc, viewController: vcont, context: ctxt)
		}
		ctxt.set(name: "_alert", function: alertfunc)

		/* _openPanel */
		let openPanelFunc: @convention(block) (_ titleval: JSValue, _ typeval: JSValue, _ ctypevals: JSValue, _ cbfunc: JSValue) -> Void = {
			(_ titleval: JSValue, _ typeval: JSValue, _ ctypevals: JSValue, _ cbfunc: JSValue) -> Void in
			self.openPanel(context: ctxt, titleValue: titleval, typeValue: typeval, contentTypeValues: ctypevals, callbackValue: cbfunc)
		}
		ctxt.set(name: "_openPanel", function: openPanelFunc)

		/* _savePanel */
		let savePanelFunc: @convention(block) (_ titleval: JSValue, _ cbfunc: JSValue) -> Void = {
			(_ titleval: JSValue, _ cbfunc: JSValue) -> Void in
			self.savePanel(context: ctxt, titleValue: titleval, callbackValue: cbfunc)
		}
		ctxt.set(name: "_savePanel", function: savePanelFunc)
	}

	private func openPanel(context ctxt: KEContext, titleValue titleval: JSValue, typeValue typeval: JSValue, contentTypeValues ctypevals: JSValue, callbackValue cbfunc: JSValue) {
		if let title  = valueToString(value: titleval),
		   let type   = valueToFileType(type: typeval) {
			let ctypes = valueToContentTypes(contentTypes: ctypevals)
			CNExecuteInMainThread(doSync: false, execute: {
				() -> Void in self.openPanel(context: ctxt, title: title, fileType: type, contentTypes: ctypes, callback: cbfunc)
			})
		} else {
			if let param = JSValue(nullIn: ctxt) {
				cbfunc.call(withArguments: [param])
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate return value", atFunction: #function, inFile: #file)
			}
		}
	}

	#if os(OSX)
	private func openPanel(context ctxt: KEContext, title ttl: String, fileType type: CNFileType, contentTypes ctypes: Array<UTType>, callback cbfunc: JSValue) {
		URL.openPanel(title: ttl, type: type, contentTypes: ctypes, callback: {
			(_ urlp: URL?) -> Void in
			let param: JSValue
			if let url = urlp {
				param = JSValue(URL: url, in: ctxt)
			} else {
				param = JSValue(nullIn: ctxt)
			}
			CNExecuteInUserThread(level: .event, execute: {
				cbfunc.call(withArguments: [param])
			})
		})
	}
	#else
	private func openPanel(context ctxt: KEContext, title ttl: String, fileType type: CNFileType, contentTypes ctypes: Array<UTType>, callback cbfunc: JSValue) {
		guard let vcont = mViewController else {
			CNLog(logLevel: .error, message: "No view controller for openPanel", atFunction: #function, inFile: #file)
			return
		}
		// Parent controller
		let pcont  = vcont.parentController
		// Open document picker
		let picker = pcont.documentPickerViewController(callback: {
			(_ urlp: URL?) -> Void in
			let param: JSValue
			if let url = urlp {
				param = JSValue(URL: url, in: ctxt)
			} else {
				param = JSValue(nullIn: ctxt)
			}
			CNExecuteInUserThread(level: .event, execute: {
				cbfunc.call(withArguments: [param])
			})
		})
		let docdir = FileManager.default.documentDirectory
		CNLog(logLevel: .detail, message: "open-picker: \(docdir.path)", atFunction: #function, inFile: #file)
		picker.openPicker(URL: docdir)
	}
	#endif

	private func savePanel(context ctxt: KEContext, titleValue titleval: JSValue, callbackValue cbfunc: JSValue) {
		if let title = valueToString(value: titleval) {
			savePanel(context: ctxt, title: title, callback: cbfunc)
		} else {
			if let param = JSValue(nullIn: ctxt) {
				cbfunc.call(withArguments: [param])
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate return value", atFunction: #function, inFile: #file)
			}
		}
	}

	#if os(OSX)
	private func savePanel(context ctxt: KEContext, title ttl: String, callback cbfunc: JSValue) {
		URL.savePanel(title: ttl, outputDirectory: nil, callback: {
			(_ urlp: URL?) -> Void in
			let param: JSValue
			if let url = urlp {
				param = JSValue(URL: url, in: ctxt)
			} else {
				param = JSValue(nullIn: ctxt)
			}
			cbfunc.call(withArguments: [param])
		})
	}
	#else
	private func savePanel(context ctxt: KEContext, title ttl: String, callback cbfunc: JSValue) {
		if let param = JSValue(nullIn: ctxt) {
			cbfunc.call(withArguments: [param])
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate return value", atFunction: #function, inFile: #file)
		}
	}
	#endif

	private func defineBuiltinFuntion(context ctxt: KEContext, viewController vcont: AMComponentViewController, resource res: KEResource, environment env: CNEnvironment, config conf: KEConfig) {
		/* Redefine _runThread method */
		let runfunc: @convention(block) (_ pathval: JSValue, _ consval: JSValue) -> JSValue = {
			(_ pathval: JSValue, _ consval: JSValue) -> JSValue in
			if let path = self.valueToURL(value: pathval),
			   let cons = self.valueToConsole(value: consval) {
				switch self.resourceFromFile(path) {
				case .success(let resource):
					switch self.mainScriptInResource(resource) {
					case .success(let mainfile):
                                                let thread: KLScriptThread
                                                switch resource.applicationType {
                                                case .terminal:
                                                        thread = KLScriptThread(scriptFile: mainfile, resource: res, virtualMachine: ctxt.virtualMachine, console: cons, environment: env, config: conf)
                                                case .window:
                                                        thread = AMThread(viewController: vcont, virtualMachine: ctxt.virtualMachine, scriptFile: mainfile, resource: resource, console: cons, environment: env, config: conf)
                                                @unknown default:
                                                        CNLog(logLevel: .error, message: "Can not happend: \(#function)")
                                                        thread = KLScriptThread(scriptFile: path, resource: res, virtualMachine: ctxt.virtualMachine, console: cons, environment: env, config: conf)
                                                }
						let object = KLThread(thread: thread, context: ctxt)
						return JSValue(object: object, in: ctxt)
					case .failure(let err):
						CNLog(logLevel: .error, message: err.toString())
					}
				case .failure(let err):
					CNLog(logLevel: .error, message: err.toString())
				}
			} else {
				CNLog(logLevel: .error, message: "Unexpected parameter types")
			}
			return JSValue(undefinedIn: ctxt)
		}
		ctxt.set(name: "_runThread", function: runfunc)
	}

	private func parameterToViewName(parameter param: JSValue) -> String? {
		return param.toString()
	}

	private func enterView(viewController vcont: AMComponentViewController, context ctxt: KEContext, viewName vname: String, argument arg: CNValue, resource res: KEResource, callback cbfunc: JSValue) {
		if let parent = vcont.parent as? AMMultiComponentViewController {
			let vcallback: AMMultiComponentViewController.ViewSwitchCallback = {
				(_ val: CNValue) -> Void in
				CNExecuteInUserThread(level: .event, execute: {
					let sval = val.toJSValue(context: ctxt)
					cbfunc.call(withArguments: [sval])
				})
			}
			parent.pushViewController(viewName: vname, argument: arg, resource: res, callback: vcallback)
		} else {
			CNLog(logLevel: .error, message: "No parent controller")
		}
	}

	private func leaveView(viewController vcont: AMComponentViewController, returnValue retval: CNValue) {
		CNExecuteInMainThread(doSync: false, execute: {
			() -> Void in
			if let parent = vcont.parent as? AMMultiComponentViewController {
				if !parent.popViewController(returnValue: retval) {
					CNLog(logLevel: .error, message: "Failed to pop view")
				}
			} else {
				CNLog(logLevel: .error, message: "No parent controller")
			}
		})
	}

	private func importBuiltinLibrary(context ctxt: KEContext, console cons: CNFileConsole, config conf: KEConfig)
	{
		let libnames = ["window", "panel"]
		do {
			for libname in libnames {
				if let url = CNFilePath.URLForResourceFile(fileName: libname, fileExtension: "js", subdirectory: "Library", forClass: AMLibraryCompiler.self) {
					let script = try String(contentsOf: url, encoding: .utf8)
					let _ = compileStatement(context: ctxt, statement: script, sourceFile: url, console: cons, config: conf)
				} else {
					cons.error(string: "Built-in script \"\(libname)\" is not found.\n")
				}
			}
		} catch {
			cons.error(string: "Failed to read built-in script in KiwiComponents")
		}
	}

	private func valueToString(value val: JSValue) -> String? {
		if val.isString {
			return val.toString()
		} else {
			return nil
		}
	}

	private func valueToFileType(type tval: JSValue) -> CNFileType? {
		if let num = tval.toNumber() {
			if let sel = CNFileType(rawValue: num.intValue) {
				return sel
			}
		}
		return nil
	}

	private func valueToContentTypes(contentTypes tval: JSValue) -> Array<UTType> {
		if tval.isArray {
			var types: Array<UTType> = []
			if let vals = tval.toArray() {
				let tmgr = CNUTTypeManager.shared
				for elm in vals {
					if let str = elm as? String {
						if let ctype = tmgr.extensionToType(extension: str) {
							types.append(ctype)
						} else {
							CNLog(logLevel: .error, message: "Unknown extension: \(str)")
						}
					}
				}
			}
			return types
		}
		return []
	}

	private func resourceFromFile(_ packdir: URL) -> Result<KEResource, NSError> {
                switch FileManager.default.checkFileType(pathString: packdir.path)  {
                case .success(let ftype):
                        switch ftype {
                        case .directory:
                                let res = KEResource(packageDirectory: packdir)
                                if let err = res.loadManifest() {
                                    let err = NSError.fileError(message: "Failed to load resource from \(packdir.path): \(err.toString())")
                                    return .failure(err)
                                } else {
                                    return .success(res)
                                }
                        case .file:
                                let err = NSError.fileError(message: "The directory is required: \(packdir.path)")
                                return .failure(err)
                        @unknown default:
                                let err = NSError.fileError(message: "Internal error")
                                return .failure(err)
                        }
                case .failure(let err):
                        return .failure(err)
                }
	}

	private func mainScriptInResource(_ res: KEResource) -> Result<URL, NSError> {
		if let url = res.application() {
			return .success(url)
		} else {
			let err = NSError.fileError(message: "No application section in resource: \(res.packageDirectory.path())")
			return .failure(err)
		}
	}
}

