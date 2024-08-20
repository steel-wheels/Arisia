/**
 * @file	AMMultiComponentViewController.swift
 * @brief	Define AMMultiComponentViewController class
 * @par Copyright
 *   Copyright (C) 2020-2022 Steel Wheels Project
 */

import KiwiControls
import KiwiEngine
import CoconutData
import Foundation

open class AMMultiComponentViewController: KCMultiViewController
{
	public typealias ViewSwitchCallback = KCMultiViewController.ViewSwitchCallback

	private var mResource: KEResource?		= nil

	public var resource: KEResource? { get { return mResource }}

	@objc required dynamic public init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	open override func viewDidLoad() {
		mResource    = loadResource()
		super.viewDidLoad()
	}

	open func loadResource() -> KEResource {
		return KEResource(packageDirectory: Bundle.main.bundleURL)
	}

	public func pushViewController(viewName vname: String, argument arg: CNValue, resource res: KEResource, callback cbfunc: @escaping ViewSwitchCallback) {
		let viewctrl = AMComponentViewController(parentViewController: self)
		viewctrl.setup(viewName: vname, argument: arg, resource: res)
		super.pushViewController(viewController: viewctrl, callback: cbfunc)
	}

	public override func popViewController(returnValue retval: CNValue) -> Bool {
		/* Pop the view */
		return super.popViewController(returnValue: retval)
	}
}

