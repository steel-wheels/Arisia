/**
 * @file	AMComponentViewController.swift
 * @brief	Define AMComponentViewController class
 * @note This file is copied from KMComponentViewController.swift in KiwiComponent framework
 * @par Copyright
 *   Copyright (C) 2020-2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiControls
import KiwiEngine
import KiwiLibrary
import CoconutData
import JavaScriptCore
import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif

open class AMComponentViewController: KCSingleViewController
{
	private var mContext:			KEContext
	private var mViewName:			String?
	private var mArgument:			CNValue
	private var mResource:			KEResource?
	private var mEnvironment:		CNEnvironment
	private var mDidAlreadyLinked:		Bool
	private var mDidAlreadyInitialized:	Bool

	public override init(parentViewController parent: KCMultiViewController){
		guard let vm = JSVirtualMachine() else {
			fatalError("Failed to allocate VM")
		}
		mContext		= KEContext(virtualMachine: vm)
		mViewName		= nil
		mArgument		= CNValue.null
		mResource		= nil
		mEnvironment		= CNEnvironment(parent: CNEnvironment.shared)
		mDidAlreadyLinked	= false
		mDidAlreadyInitialized	= false
		super.init(parentViewController: parent)
	}

	@objc required dynamic public init?(coder: NSCoder) {
		guard let vm = JSVirtualMachine() else {
			fatalError("Failed to allocate VM")
		}
		mContext		= KEContext(virtualMachine: vm)
		mViewName		= nil
		mArgument		= CNValue.null
		mResource		= nil
		mEnvironment		= CNEnvironment(parent: CNEnvironment.shared)
		mDidAlreadyLinked	= false
		mDidAlreadyInitialized	= false
		super.init(coder: coder)
	}

	public var context: KEContext { get { return mContext }}

	public func setup(viewName vname: String, argument arg: CNValue, resource res: KEResource) {
		mViewName	= vname
		mArgument	= arg
		mResource	= res
	}

	open override func loadContext() -> KCView? {
		ALFrameManager.shared.importBuiltinComponents()

		let console  = super.globalConsole

		guard let viewname = mViewName else {
			console.log(string: "No view name\n")
			return nil
		}

		guard let resource = mResource else {
			console.log(string: "No resource\n")
			return nil
		}

		let script:	String
		let srcfile:	URL?
		if let url = resource.view(identifier: viewname) {
            if let scr = url.loadContents() as? String {
                script		= scr
                srcfile		= url
            } else {
                console.log(string: "Failed to load view from: \(url.path)\n")
                return nil
            }
		} else {
			console.log(string: "Failed to load view named: \(viewname)\n")
			return nil
		}

		let loglevel = CNPreference.shared.systemPreference.logLevel
		let config   = ALConfig(applicationType: .window, doStrict: true, logLevel: loglevel)

		if loglevel.isIncluded(in: .detail) {
			let txt = resource.toText()
			console.log(string: "Resource for view")
			console.log(string: txt.toStrings().joined(separator: "\n"))
		}

		/* Define global variable: Argument */
		let obj  = mArgument.toJSValue(context: self.context)

		self.context.set(name: "Argument", value: obj)

		/* import user frame declaration */
		importCustomFrameDeclaration(viewNamae: viewname, resource: resource, console: console)

		/* setup environment */
		mEnvironment.setPackageDirectory(path: resource.packageDirectory.path)

		guard self.compile(viewController: self, context: self.context, resource: resource, environment: mEnvironment, console: console, config: config) else {
			console.log(string: "Failed to compile base\n")
			return nil
		}

		/* Execute the script */
		let executor = ALScriptExecutor(config: config)
		guard let rootview = executor.execute(context: context, script: script, sourceFile: srcfile, resource: resource, console: console) else {
			let fname: String
			if let url = srcfile {
				fname = ": " + url.path
			} else {
				fname = ""
			}
			console.log(string: "[Error] Failed to compile script\(fname)")
			return nil
		}

		/* Return the root view */
		if let view = rootview as? KCView {
			return view
		} else {
			console.log(string: "[Error] The root frame is not view: \(rootview)")
			return nil
		}
	}

	private func isArisiaScriptFile(sourceFile url: URL?) -> Result<Bool, NSError> {
		if let u = url {
			if let lang = ALLanguage.judge(byFileName: u.path) {
				let result: Bool
				switch lang {
				case .JavaScript:
					result = false
				case .ArisiaScript:
					result = true
				case .TypeScript:
					return .failure(NSError.fileError(message: "Can not compile TypeScript file"))
				@unknown default:
					return .failure(NSError.fileError(message: ""))
				}
				return .success(result)
			} else {
				return .failure(NSError.fileError(message: "Unknown source file exptension: \(u.path)"))
			}
		} else {
			return .failure(NSError.fileError(message: "No source file name. Can not decide Language"))
		}
	}

	private func importCustomFrameDeclaration(viewNamae vname: String, resource res: KEResource, console cons: CNConsole) {
		let packdir = res.packageDirectory
		let declurl = packdir.appending(path: "types/\(vname).frame.d.ts")
		if let ctxt = declurl.loadContents() as? String {
			let parser = CNValueTypeParser()
			switch parser.parse(source: ctxt) {
			case .success(let vtypes):
				let vmgr = CNValueTypeManager.shared
				for vtype in vtypes {
					switch vtype {
					case .enumType(let etype):
						vmgr.add(enumType: etype)
					case .interfaceType(let iftype):
						vmgr.add(interfaceType: iftype)
					default:
						cons.log(string: "[Error] Failed to import type: \(vtype.typeName)\n")
					}
				}
			case .failure(let err):
				cons.log(string: "[Error] Load to parse declaration: \(err.toString()) in \(declurl.path)\n")
			}
		} else {
			cons.log(string: "[Error] Failed to load declaration from \(declurl.path)\n")
		}
	}

	private func compile(viewController vcont: AMComponentViewController, context ctxt: KEContext, resource res: KEResource, environment env: CNEnvironment, console cons: CNFileConsole, config conf: KEConfig) -> Bool {
		let compiler = AMLibraryCompiler(viewController: vcont)
		return compiler.compile(context: ctxt, resource: res, console: cons, environment: env, config: conf)
	}

	open override func errorContext() -> KCView {
		let box = KCStackView()
		box.axis = .vertical

		let message  = KCTextField()
		message.isBold	   = true
		message.isEditable = false
		message.text       = "Failed to load context"
		box.addArrangedSubView(subView: message)

		let button = KCButton()
		button.value = .text("Continue")
		button.buttonPressedCallback = {
			() -> Void in
			let cons  = super.globalConsole
			if let parent = self.parentController as? AMMultiComponentViewController {
				if parent.popViewController(returnValue: CNValue.null) {
					cons.error(string: "Force to return previous view\n")
				} else {
					cons.error(string: "Failed to pop view\n")
				}
			} else {
				cons.error(string: "No parent controller\n")
			}
		}
		box.addArrangedSubView(subView: button)

		return box
	}
}

