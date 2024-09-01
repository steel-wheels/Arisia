/**
 * @file	main..swift
 * @brief	Main function for asc command
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaComponents
import ArisiaLibrary
import KiwiEngine
import CoconutData
import JavaScriptCore
import Foundation

func main(arguments args: Array<String>) {
	let console = CNFileConsole()
	let cmdline = CommandLineParser(console: console)
	guard let (config, _) = cmdline.parseArguments(arguments: Array(args.dropFirst())) else {
		return
	}

	/* Load script */
	let srcurl = URL(fileURLWithPath: config.scriptFile)
	let lconf  = ALConfig(applicationType: config.applicationType, doStrict: true, logLevel: .defaultLevel)
	guard let source = srcurl.loadContents() as String? else {
		console.print(string: "[Error] Failed to load source from \(srcurl.path)")
		return
	}

	/* Register component allocator */
	ALFrameManager.shared.importBuiltinComponents()

	/* Load resource (if package directory option is required) */
	let resource: KEResource
	switch loadResource(config: config) {
	case .success(let res):
		resource = res
	case .failure(let err):
		console.print(string: "[Error] Failed to load resource: error=\(err.toString())\n")
		return
	}

	/* Parse script */
	let parser = ALParser(config: lconf)
	let rootfrm: ALFrameIR
	switch parser.parse(source: source, sourceFile: srcurl) {
	case .success(let frm):
		rootfrm = frm
	case .failure(let err):
		console.print(string: "[Error] Parse error: \(err.toString())")
		return
	}

	/* Analuze script */
	let analyzer = ALScriptAnalyzer(resource: resource, config: lconf)
	if let err = analyzer.anayze(frame: rootfrm) {
		console.print(string: "[Error] Analyze error: \(err.toString())")
		return
	}

	/* Select output */
	//let output: CNTextSection
	switch config.outputFormat {
 	case .TypeScript:
		/* generate script */
		let output = CNTextSection()
        output.add(text: generateReference(config: config, resource: resource, console: console))
		switch generateScript(rootFrame: rootfrm, language: .TypeScript, resource: resource, config: lconf) {
		case .success(let txt):
			output.add(text: txt)
			outputScript(config: config, text: output, console: console)
		case .failure(let err):
			console.print(string: "[Error] Failed to generate TypeScript: \(err.toString())\n")
			return
		}
	case .TypeDeclaration:
		let path      = ALFramePath(path: [], instanceName: ALConfig.rootInstanceName, className: lconf.rootFrameName)
		let generator = TypeDeclGenerator(resource: resource, config: lconf)
		let output    = CNTextSection()

		/* generate frame types */
		switch generator.generateFrameInterface(path: path, frame: rootfrm) {
		case .success(let iftypes):
			/* encode frame interfaces */
			for iftype in  sort(interfaceTypes: iftypes) {
				output.add(text: iftype.toDeclaration(isInside: false))
			}
		case .failure(let err):
			console.print(string: "[Error] Failed to generate declaration: \(err.toString())\n")
			return
		}

		/* encode user defined types */
		outputScript(config: config, text: output, console: console)
	}
}

private func generateScript(rootFrame root: ALFrameIR, language lang: ALLanguage, resource res: KEResource, config conf: ALConfig) -> Result<CNTextSection, NSError>
{
	let compiler = ALScriptCompiler(resource: res, config: conf)
	switch compiler.compile(rootFrame: root, language: lang) {
	case .success(let text):
		return .success(text)
	case .failure(let err):
		return .failure(err)
	}
}

private func loadResource(config conf: Config) -> Result<KEResource, NSError> {
	let packdir: URL
	if let pdir = conf.packageDirectory {
		packdir = pdir
	} else {
		let scrurl = URL(filePath: conf.scriptFile)
		packdir = scrurl.deletingLastPathComponent()
	}
	let res    = KEResource(packageDirectory: packdir)
        if let err = res.loadManifest() {
                return .failure(err)
        } else {
                return .success(res)
        }
}

private func generateReference(config conf: Config, resource res: KEResource, console cons: CNConsole) -> CNTextSection
{
	var files: Array<String> = [
		"types/ArisiaPlatform.d.ts"
	]
	files.append(contentsOf: conf.importFiles)

    /* Add user defined files */
    for path in res.typePaths() {
        files.append(path)
    }

	/* Add reference for <script-file>.frame.d.ts */
	switch conf._frameFileName() {
	case .success(let file):
		files.append("types/\(file)")
	case .failure(let err):
		cons.print(string: "[Error] Failed to decide interface declaration file: \(err.toString())\n")
	}

	let result = CNTextSection()
	for file in files {
		let line = CNTextLine(string: "/// <reference path=\"\(file)\"/>")
		result.add(text: line)
	}
	return result
}

private func sort(interfaceTypes iftypes: Array<CNInterfaceType>) -> Array<CNInterfaceType> {
	/* mark for each types */
	var marks: Dictionary<String, Bool> = [:]
	for iftype in iftypes {
		marks[iftype.name] = false
		if let btype = iftype.base {
			marks[btype.name] = false
		}
	}

	var result: Array<CNInterfaceType> = []
	for iftype in iftypes {
		addSorttedInterfaceType(result: &result, marks: &marks, soource: iftype)
	}
	return result
}

private func addSorttedInterfaceType(result res: inout Array<CNInterfaceType>,
				     marks mrks: inout Dictionary<String, Bool>, soource src: CNInterfaceType)
{
	guard let mark = mrks[src.name] else {
		return
	}
	if !mark {
		if let base = src.base {
			addSorttedInterfaceType(result: &res, marks: &mrks, soource: base)
		}
		res.append(src)
		mrks[src.name] = true
	}
}

private func outputScript(config conf: Config, text txt: CNText, console cons: CNFileConsole)
{
	switch conf.outputFileName() {
	case .success(let filename):
		if let file = CNFile.open(forWriting: URL(fileURLWithPath: filename)){
			let str = txt.toStrings().joined(separator: "\n") + "\n"
			file.put(string: str)
		} else {
			cons.print(string: "[Error] Failed to write file: \(filename)\n")
		}
	case .failure(let err):
		cons.print(string: "[Error] \(err.toString())\n")
	}
}

main(arguments: CommandLine.arguments)

