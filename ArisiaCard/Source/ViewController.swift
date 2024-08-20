/**
 * @file ViewController.swift
 * @brief Define ViewController class
 * @par Copyright
 *   Copyright (C) 2022 2024 Steel Wheels Project
 */

import ArisiaComponents
import KiwiEngine
import CoconutData
#if os(iOS)
	import UIKit
#else
	import Cocoa
#endif

class ViewController: AMMultiComponentViewController
{
	open override func loadResource() -> KEResource {
                /* Add package search path */
                if let resdir = FileManager.default.resourceDirectory {
                        CNEnvironment.shared.addPackagePath(path: resdir)
                }
		/* Load resource */
		if let path = Bundle.main.path(forResource: "Home", ofType: "jspkg") {
			let resource = KEResource.init(packageDirectory: URL(fileURLWithPath: path))
			if let err = resource.loadManifest() {
				CNLog(logLevel: .error, message: "Failed to load manifest: \(err.toString())")
			}
			return resource
		} else {
			CNLog(logLevel: .error, message: "Failed to load package")
			fatalError("Failed to load package")
		}
	}

	open override func viewDidLoad() {
		super.viewDidLoad()

		/* Add subview */
		if let res = self.resource {
			let cbfunc: AMMultiComponentViewController.ViewSwitchCallback = {
				(_ val: CNValue) -> Void in
				let valstr: String
				if let str = val.toString() {
					valstr = str
				} else {
					valstr = "<unknown>"
				}
				NSLog("mainView: return_val=\(valstr)")
			}
			let _ = super.pushViewController(viewName: "home", argument: CNValue.null, resource: res, callback: cbfunc)
		}
	}
}
