/**
 * @file AMSprite.swift
 * @brief	Define AMSprite  class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiLibrary
import KiwiEngine
import KiwiControls
import CoconutData
import SpriteKit
import JavaScriptCore
import Foundation

public class AMSprite: KCSpriteView, ALFrame
{
	public static let ClassName	= "Sprite"

	private struct Node {
		var decl:	CNSpriteNodeDecl
		var node:	SKNode
		public init(decl d: CNSpriteNodeDecl, node n: SKNode) {
			self.decl = d
			self.node = n
		}
	}

	private static let AddNodeItem		= "addNode"
	private static let BackgroundItem	= "background"
	private static let ConsoleItem		= "console"
	private static let IsPausedItem		= "isPaused"
	private static let IsStartedItem	= "isStarted"
	private static let ScriptItem		= "script"
	private static let StartItem		= "start"
	private static let NodesItem		= "nodes"

	private var mNodeDeclarations:	Array<CNSpriteNodeDecl>		// identifier, decl
	private var mContext:		KEContext
	private var mEnvironment:	CNEnvironment
	private var mConsole:		CNFileConsole

	private var mFrameCore:		ALFrameCore
	private var mPath:		ALFramePath

	private var mScene:		KLSpriteScene?

	public var core: ALFrameCore { get { return mFrameCore }}
	public var path: ALFramePath { get { return mPath 	}}

	public init(context ctxt: KEContext){
		mNodeDeclarations	= []
		mContext		= ctxt
		mEnvironment		= CNEnvironment(parent: CNEnvironment.shared)
		mConsole		= CNFileConsole()
		mFrameCore		= ALFrameCore(frameName: AMSprite.ClassName, context: ctxt)
		mPath			= ALFramePath.empty
		mScene			= nil
		let frame		= CGRect(x: 0.0, y: 0.0, width: 188, height: 21)
		super.init(frame: frame)
		mFrameCore.owner = self
	}

	public required init?(coder: NSCoder) {
		fatalError("Not supported")
	}

	public static var constructor: ALFrameConstructor { get {
		let afunc: ALFrameConstructor.AllocateFunction = {
			(_ ctxt: KEContext) -> ALFrame in return AMSprite(context: ctxt)
		}
		let bfunc: ALFrameConstructor.BaseInterfaceFunction = {
			() -> CNInterfaceType in return baseInterfaceType
		}
		let sfunc: ALFrameConstructor.SubInterfaceFunction = {
			(_ path: ALFramePath, _ frm: ALFrameIR, _ res: KEResource) -> Array<CNInterfaceType> in
			return []
		}
		return ALFrameConstructor(frameName: ClassName, allocaFunc: afunc, baseInterfaceFunction: bfunc, subInterfaceFunction: sfunc)
	}}

	static private var baseInterfaceType: CNInterfaceType { get {
		typealias M = CNInterfaceType.Member

		let vmgr   = CNValueTypeManager.shared
		let ifname = ALFunctionInterface.defaultInterfaceName(frameName: AMSprite.ClassName)
		if let iftype = vmgr.searchInterfaceType(byTypeName: ifname) {
			return iftype
		} else {
			let nodeif: CNValueType
			if let nif = vmgr.searchInterfaceType(byTypeName: CNSpriteNodeDecl.InterfaceName) {
				nodeif = .interfaceType(nif)
			} else {
				CNLog(logLevel: .error, message: "\(CNSpriteNodeDecl.InterfaceName) interface is NOT found", atFunction: #function, inFile: #file)
				nodeif = .numberType
			}

			let baseif = ALDefaultFrame.baseInterfaceType
			let ptypes: Array<M> = [
				// func addDeclaration(identifier ident: String, imageName imgname: String, scriptPath scrpath: String, count cnt: Int)
				M(name: AMSprite.AddNodeItem,
				  type: .functionType(.voidType, [
					.stringType,
					.stringType,
					.numberType
				  ])),
				M(name: AMSprite.BackgroundItem,	type: .stringType),
				M(name: AMSprite.IsPausedItem,		type: .boolType),
				M(name: AMSprite.IsStartedItem,		type: .functionType(.boolType, [])),
				M(name: AMSprite.ScriptItem,		type: .stringType),
				M(name: AMSprite.StartItem,		type: .functionType(.voidType, [])),
				M(name: AMSprite.NodesItem,		type: .arrayType(nodeif))
			]
			let newif = CNInterfaceType(name: ifname, base: baseif, members: ptypes)
			vmgr.add(interfaceType: newif)
			return newif
		}
	}}

	public func setup(path pth: ArisiaLibrary.ALFramePath, resource res: KiwiEngine.KEResource, console cons: CNFileConsole) -> NSError? {
		/* Set path of this frame */
		mPath = pth

		/* Set property types */
		defineInterfaceType(interfaceType: AMSprite.baseInterfaceType)

		/* Set default properties */
		self.setupDefaulrProperties()

		guard let scn = self.scene else {
			CNLog(logLevel: .error, message: "No scene", atFunction: #function, inFile: #file)
			return NSError.internalError(message: "No scene")
		}

		/* set　context */
		if let vm = JSVirtualMachine() {
			let ctxt = KEContext(virtualMachine: vm)
			scn.context = ctxt
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate VM", atFunction: #function, inFile: #file)
			return NSError.internalError(message: "Failed to allocate VM")
		}

		/* console item */
		if let consval = objectValue(name: AMSprite.ConsoleItem) as? KLConsole {
			mConsole = consval.console
		} else {
			let consobj = KLConsole(context: mContext, console: cons)
			setObjectValue(name: AMSprite.ConsoleItem, value: consobj)
			mConsole = cons
		}
		addObserver(propertyName: AMSprite.ConsoleItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			if let consval = param.toObject() as? KLConsole {
				self.mConsole = consval.console
			} else {
				CNLog(logLevel: .error, message: "Failed to allocate VM", atFunction: #function, inFile: #file)
			}
		})

		/* background item */
		if let imgname = stringValue(name: AMSprite.BackgroundItem) {
			if let url = res.imageURL(identifier: imgname) {
                scn.setBackground(imageFile: url)
			} else {
				CNLog(logLevel: .error, message: "The image named \"\(imgname)\" is not found")
			}
		}

		/* decode node declarations */
		let decls = decodeNodeDeclarations()
		for decl in decls {
			mNodeDeclarations.append(decl)
		}

		/* load scene script */
		loadSceneScript(resource: res, console: cons)

		/* addNode item */
		let addNodeFunc: @convention(block) (_ image: JSValue, _ script: JSValue, _ count: JSValue) -> Void = {
			(_ image: JSValue, _ script: JSValue, _ count: JSValue) -> Void in
			return self.addNode(image, script, count)
		}
		if let funcval = JSValue(object: addNodeFunc, in: mContext) {
			setValue(name: AMSprite.AddNodeItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMSprite.AddNodeItem) function", atFunction: #function, inFile: #file)
		}

		/* start item */
		let startFunc: @convention(block) () -> Void = {
			() -> Void in self.start(scene: scn, resource: res, console: cons)
		}
		if let funcval = JSValue(object: startFunc, in: mContext) {
			setValue(name: AMSprite.StartItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate \(AMSprite.StartItem) function", atFunction: #function, inFile: #file)
		}

		/* isPaused item */
		let paused = true // The initial value is true
		setBooleanValue(name: AMSprite.IsPausedItem, value: paused)
		CNExecuteInMainThread(doSync: false, execute: {
			() -> Void in self.isPaused = paused
		})
		addObserver(propertyName: AMSprite.IsPausedItem, listnerFunction: {
			(_ param: JSValue) -> Void in
			self.pause(enable: param.toBool(), console: cons)
		})

		/* isStarted function */
		let startedfunc: @convention(block) () -> JSValue = {
			() -> JSValue in
			return JSValue(bool: self.isStarted, in: self.mContext)
		}
		if let funcval = JSValue(object: startedfunc, in: self.mContext) {
			setValue(name: AMSprite.IsStartedItem, value: funcval)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate isStarted function", atFunction: #function, inFile: #file)
		}

		return nil // no error
	}

	private func decodeNodeDeclarations() ->  Array<CNSpriteNodeDecl>  {
		guard let nodesval = value(name: AMSprite.NodesItem) else {
			CNLog(logLevel: .error, message: "No \(AMSprite.NodesItem)", atFunction: #function, inFile: #file)
			return []
		}
		let converter = KLScriptValueToNativeValue()
		let nodesnval = converter.convert(scriptValue: nodesval)
		guard let nodesarr = nodesnval.toArray() else {
			CNLog(logLevel: .error, message: "Unexpected node declaration", atFunction: #function, inFile: #file)
			return []
		}
		var result: Array<CNSpriteNodeDecl> = []
		for node in nodesarr {
			if let attrdict = node.toDictionary() {
				switch CNSpriteNodeDecl.fromValue(value: attrdict) {
				case .success(let attrdecl):
					result.append(attrdecl)
				case .failure(let err):
					CNLog(logLevel: .error, message: "Failed to add node: \(err.toString())")
				}
			}
		}
		return result
	}

	private func start(scene scn: CNSpriteScene, resource res: KEResource, console cons: CNFileConsole) {
		guard !super.isStarted else {
			return // already started
		}
		let nodes = self.allocateNode(resource: res)
		self.loadNodeScripts(nodes: nodes, resource: res, console: cons)
		/* set initialize callback */
		scn.setupCallbacks(initCallback: {
			() -> Bool in return self.callMains(scene: scn, nodes: nodes, field: scn.field, resource: res, console: cons)
		}, finishCallback: {
			(_ time: TimeInterval) -> Bool in return self.checkFinish(timeInterval: time, scene: scn)
		})
		CNExecuteInMainThread(doSync: false, execute: {
			() -> Void in
			self.start()
			self.setBooleanValue(name: AMSprite.IsPausedItem, value: false)
		})
	}

	public func pause(enable en: Bool, console cons: CNFileConsole) {
		guard self.isStarted else {
			cons.error(string: "[Error] Failed to pause the scene")
			return
		}
		CNExecuteInMainThread(doSync: false, execute: {
			self.isPaused = en
		})
	}

	private func loadSceneScript(resource res: KEResource, console cons: CNFileConsole) {
		guard let scr = stringValue(name: AMSprite.ScriptItem), let scn = self.scene else {
			cons.print(string: "[Error] No scene script\n")
			return
		}
		guard let srcfile = pathToURL(script: scr, resource: res, console: cons) else {
			return
		}
		if !scn.loadScript(scriptFile: srcfile, resource: res, environment: mEnvironment, console: cons) {
			CNLog(logLevel: .error, message: "Failed to load script: \(scr)")
		}
	}

	private func addNode(_ imgval: JSValue, _ scrval: JSValue, _ cntval: JSValue) {
		guard let imgname = imgval.toString() else {
			CNLog(logLevel: .error, message: "Unexpected image name type", atFunction: #function, inFile: #file)
			return
		}
		guard let scrpath = scrval.toString() else {
			CNLog(logLevel: .error, message: "Unexpected script path type", atFunction: #function, inFile: #file)
			return
		}
		guard let cntnum = cntval.toNumber() else {
			CNLog(logLevel: .error, message: "Unexpected count type", atFunction: #function, inFile: #file)
			return
		}
		let decl = CNSpriteNodeDecl(material: .image, value: imgname, script: scrpath, count: cntnum.intValue)
		mNodeDeclarations.append(decl)
	}

	private func allocateNode(resource res: KEResource) -> Array<Node> {
		var result: Array<Node> = []
		var nodeid: Int = 0
		for decl in mNodeDeclarations {
			for _ in 0..<decl.count {
				let node = allocateNode(machine: "car", nodeId: nodeid, declaration: decl, resource: res)
				CNExecuteInMainThread(doSync: false, execute: {
					() -> Void in self.add(child: node)
				})
				result.append(Node(decl: decl, node: node))
				nodeid += 1
			}
		}
		return result
	}

	private func allocateNode(machine mcn: String, nodeId nid: Int, declaration decl: CNSpriteNodeDecl, resource res: KEResource) -> SKNode{
		let result: SKNode
		switch decl.material {
		case .scene, .background:
			CNLog(logLevel: .error, message: "Unsupported material: \(decl.value)", atFunction: #function, inFile: #file)
			result = SKLabelNode(text: "?")
		case .image:
			if let url = res.imageURL(identifier: decl.value) {
                result = SKSpriteNode(imageNamed: url.path)
			} else {
				CNLog(logLevel: .error, message: "Non exist image name: \(decl.value)", atFunction: #function, inFile: #file)
				result = SKLabelNode(text: "?")
			}
		case .text:
			result = SKLabelNode(text: decl.value)
		@unknown default:
			CNLog(logLevel: .error, message: "Unknown node type", atFunction: #function, inFile: #file)
			result = SKLabelNode(text: "?")
		}
		if let vm = JSVirtualMachine() {
			result.setupNode(virtualMachine: vm, material: decl.material, machine: mcn, nodeId: nid)
		} else {
			CNLog(logLevel: .error, message: "Failed to allocate VM", atFunction: #function, inFile: #file)
		}
		return result
	}

	private func loadNodeScripts(nodes nds: Array<Node>, resource res: KEResource, console cons: CNFileConsole) {
		guard let scn = self.scene else {
			cons.print(string: "[Error] No scene\n")
			return
		}
		let fld = scn.field

		/* load script for nodes */
		for node in nds{
			loadNodeScript(node: node.node, field: fld, nodeDeclaration: node.decl, resource: res, console: cons)
		}
	}

	private func loadNodeScript(node nd: SKNode, field fld: CNSpriteField, nodeDeclaration ndecl: CNSpriteNodeDecl, resource res: KEResource, console cons: CNFileConsole) {
		guard let scrurl = pathToURL(script: ndecl.script, resource: res, console: cons) else {
			return
		}
		if !nd.loadScript(scriptFile: scrurl, resource: res, environment: mEnvironment, console: cons) {
			CNLog(logLevel: .error, message: "Failed to load script: \(scrurl.path)")
		}
	}

	private func callMains(scene scn: CNSpriteScene, nodes nds: Array<Node>, field fld: CNSpriteField, resource res: KEResource, console cons: CNFileConsole) -> Bool {
		/* call main function for scene */
		if !callSceneMain(scene: scn, rfield: fld, resource: res, console: cons) {
			return false
		}
		/* call main function for nodes */
		for node in nds {
			if !callNodeMain(node: node.node, field: fld, resource: res, console: cons) {
				return false
			}
		}
		return true
	}

	private func callSceneMain(scene scn: CNSpriteScene, rfield fld: CNSpriteField, resource res: KEResource, console cons: CNFileConsole) -> Bool {
		guard let ctxt = scn.context else {
			cons.print(string: "[Error] No scene core or context\n")
			return false
		}
		/* call main function */
		let sceneobj = KLSpriteScene(scene: scn, context: ctxt)
		let fieldobj = KLSpriteField(spriteField: fld, context: mContext)
		if let mainfunc = ctxt.get(name: "main"),
		   let scnval   = JSValue(object: sceneobj, in: ctxt),
		   let fieldval = JSValue(object: fieldobj, in: ctxt){
			mScene = sceneobj
			CNExecuteInUserThread(level: .thread, execute: {
				() -> Void in mainfunc.call(withArguments: [scnval, fieldval])
			})
			return true
		} else {
			cons.print(string: "[Error] No main function in sprite scene script\n")
			return false
		}
	}

	private func callNodeMain(node nd: SKNode, field fld: CNSpriteField, resource res: KEResource, console cons: CNFileConsole) -> Bool {
		guard let ctxt = nd.context else {
			cons.print(string: "[Error] No context")
			return false
		}
		/* call main function */
		let nodeobj  = KLSpriteNode(node: nd, context: ctxt)
		let fieldobj = KLSpriteField(spriteField: fld, context: ctxt)
		if let mainfunc = ctxt.get(name: "main"),
		   let nodeval  = JSValue(object: nodeobj, in: ctxt),
		   let fieldval = JSValue(object: fieldobj, in: ctxt){
			CNExecuteInUserThread(level: .thread, execute: {
				mainfunc.call(withArguments: [nodeval, fieldval])
			})
			return true
		} else {
			cons.print(string: "[Error] No main function in sprite node script\n")
			return false
		}
	}

	private func checkFinish(timeInterval time: TimeInterval, scene scn: CNSpriteScene) -> Bool {
		let dofinish: Bool
		if let scn = mScene {
			dofinish = scn.doFinish
		} else {
			dofinish = false // No thread executed
		}
		return dofinish
	}

	private func pathToURL(script scr: String, resource res: KEResource, console cons: CNConsole) -> URL? {
		if let c = scr.first {
			let srcfile: URL
			if c == "/" {
				/* Absolute path */
				srcfile = URL(fileURLWithPath: scr)
			} else if scr.contains("/") || scr.contains(".") {
				/* Relative path */
				srcfile = URL(fileURLWithPath: scr, relativeTo: res.packageDirectory)
			} else {
				if let url = res.thread(identifier: scr) {
					srcfile = url
				} else {
					cons.print(string: "[Error] File or item named is not found: \(scr)")
					return nil
				}
			}
			return srcfile
		} else {
			cons.print(string: "[Error] Empty script file path\n")
			return nil
		}
	}
}

