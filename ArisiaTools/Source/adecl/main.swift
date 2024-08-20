/**
 * @file	main..swift
 * @brief	Main function for adecl command
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaComponents
import ArisiaLibrary
import CoconutData
import KiwiEngine
import JavaScriptCore
import Foundation

func main(arguments args: Array<String>) {
	let console = CNFileConsole()
	let cmdline = CommandLineParser(console: console)
	guard let (config, _) = cmdline.parseArguments(arguments: Array(args.dropFirst())) else {
		return
	}

	/* export component declaration */
	let fmanager = ALFrameManager.shared
	fmanager.importBuiltinComponents()
	let clsnames  = fmanager.classNames

	if config.doIsolate {
		for clsname in clsnames {
			if clsname == "Frame" {
				continue // Frame is already defined
			}
			if let iftype = fmanager.baseInterface(forComponent: clsname) {
				/* open the file to declare interfaces */
				let filename = "class-" + clsname + ".d.ts"
				guard let file = CNFile.open(forWriting: URL(fileURLWithPath: filename)) else {
					console.error(string: "[Error] Failed to write file: \(filename)\n")
					return
				}

				/* put declaration to file */
				let txt  = dump(className: clsname, interfaceType: iftype, console: console)
				file.put(string: txt.toStrings().joined(separator: "\n") + "\n")

				/* close the file */
				file.close()
			}
		}
	} else {
		/* open the file to declare interfaces */
		let filename = "ArisiaPlatform.d.ts"
		guard let file = CNFile.open(forWriting: URL(fileURLWithPath: filename)) else {
			console.error(string: "[Error] Failed to write file: \(filename)\n")
			return
		}

		/* load ArisiaComponent.d.ts */
		switch AMDeclarationLoader.loadDeclaration() {
		case .success(let text):
			/* write the file */
			file.put(string: text.toStrings().joined(separator: "\n") + "\n")
		case .failure(let err):
			console.error(string: "[Error] \(err.toString())\n")
			return
		}

		for clsname in clsnames {
			if clsname == "Frame" {
				continue // Frame is already defined
			}
			if let iftype = fmanager.baseInterface(forComponent: clsname) {
				let txt  = dump(className: clsname, interfaceType: iftype, console: console)
				file.put(string: txt.toStrings().joined(separator: "\n") + "\n")
			}
		}

		/* close the file */
		file.close()
	}
}

private func dump(className cname: String, interfaceType iftype: CNInterfaceType, console cons: CNConsole) -> CNTextSection
{
	let result = CNTextSection()

	/* Generate declaration */
	switch TypeDeclGenerator.generateBaseDeclaration(frameName: cname) {
	case .success(let txt):
		result.add(text: txt)
	case .failure(let err):
		cons.error(string: "[Error] Failed to general declaration: \(err.toString())\n")
		return result
	}

	/* Allocator function */
	let ifname = ALFunctionInterface.defaultInterfaceName(frameName: cname)
	let proto = CNTextLine(string: "declare function _alloc_\(cname)(): \(ifname) ;")
	result.add(text: proto)
	return result
}

main(arguments: CommandLine.arguments)

