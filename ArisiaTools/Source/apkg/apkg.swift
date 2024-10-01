/**
 * @file	main..swift
 * @brief	Define main function for mkjspkg command
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import KiwiLibrary
import ArisiaComponents
import ArisiaLibrary
import Foundation

let TypesDir    	= "types"

@main struct AppBoxCLI {
        static func main() async throws {
                let ecode = apkg(arguments: CommandLine.arguments)
                exit(Int32(ecode))
        }
}

func apkg(arguments args: Array<String>) -> Int
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let cmdline = CommandLineParser(console: console)
	guard let (config, _) = cmdline.parseArguments(arguments: Array(args.dropFirst())) else {
		return -1 // .parseError
	}

	/* Load resource with manifest */
	let manival: CNValue
	switch loadManifest(config: config) {
	case .success(let val):
		manival = val
	case .failure(let err):
		console.error(string: "[Error] " + err.toString() + "\n")
		return -1 // .fileError
	}

	guard let manidict = manival.toDictionary() else {
		console.error(string: "[Error] unexpected file format\n")
		return -1 // .fileError
	}

	/* Decide application type */
	let apptype: CNApplicationType
	if let _ = manidict[KEResource.ViewsCategory] {
		apptype = .window
	} else {
		apptype = .terminal
	}

	/* Make subdirectories */
	//guard makeDirectory(directoryPath: LibraryDir, config: config, console: console) else {
	//	return .fileError
	//}
	guard makeDirectory(directoryPath: TypesDir, config: config, console: console) else {
		return -1 // .fileError
	}

	/* copy files */
	if let err = copyResources(applicationType: apptype, config: config, console: console) {
		return err.rawValue
	}

	/* Allocate make info */
	let mani = Manifest()
	let make = Makefile(applicationType: apptype)

	/* definitions category */
	if let defsval = manidict[KEResource.DefinitionsCategory] {
		if let err = checkDefinitions(makefile: make, manifest: mani, definitions: defsval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* application category */
	if let appval = manidict[KEResource.ApplicationCategory] {
		if let err = checkApplication(makefile: make, manifest: mani, application: appval, config: config, console: console) {
			return err.rawValue
		}
	} else {
		console.error(string: "[Error] No \(KEResource.ApplicationCategory) category\n")
		return -1 //.fileError
	}

	/* properties category */
	if let propval = manidict[KEResource.PropertiesCategory] {
		if let err = checkProperties(makefile: make, manifest: mani, properties: propval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* views category */
	if let viewsval = manidict[KEResource.ViewsCategory] {
		if let err = checkViews(makefile: make, manifest: mani, views: viewsval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* libraries category */
	if let libsval = manidict[KEResource.LibrariesCategory] {
		if let err = checkLibraries(makefile: make, manifest: mani, libraries: libsval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* threads category */
	if let threadsval = manidict[KEResource.ThreadsCategory] {
		if let err = checkThreads(makefile: make, manifest: mani, threads: threadsval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* images category */
	if let imgsval = manidict[KEResource.ImagesCategory] {
		if let err = checkImages(makefile: make, manifest: mani, images: imgsval, config: config, console: console) {
			return err.rawValue
		}
	}

	/* tables category */
	if let tblsval = manidict[KEResource.TablesCategory] {
		if let err = checkTables(makefile: make, manifest: mani, tables: tblsval, applicationType: apptype, config: config, console: console) {
			return err.rawValue
		}
	}

	/* save files */
	if let err = save(fileName: "manifest.json", text: mani.toScript(), config: config, console: console){
		return err.rawValue
	}
	if let err = save(fileName: "Makefile", text: make.toScript(), config: config, console: console){
		return err.rawValue
	}

	return 0
}

private func loadManifest(config conf: Config) -> Result<CNValue, NSError> {
	let packdir = conf.packageDirectory
	let fileurl = packdir.appendingPathComponent("manifest.json.in")
	if let content = fileurl.loadContents() {
		let parser = CNValueParser()
		switch parser.parse(source: content as String) {
		case .success(let value):
			return .success(value)
		case .failure(let err):
			return .failure(err)
		}
	} else {
		return .failure(NSError.parseError(message: "Failed to load manifest.json.i file from \(fileurl.path())."))
	}
}

private func copyResources(applicationType apptype: CNApplicationType, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	let srcname = Makefile.libraryDecrationFileName(applicationType: apptype)

	let srcfile: URL
	switch apptype {
	case .terminal:
		if let srcdir = CNFilePath.URLForResourceDirectory(directoryName: TypesDir, subdirectory: "Library", forClass: KLLibraryCompiler.self) {
			srcfile = srcdir.appending(component: srcname)
		} else {
			cons.error(string: "[Error] No resource directory for \(srcname).\n")
			return .fileError
		}
	case .window:
		if let srcdir = CNFilePath.URLForResourceDirectory(directoryName: TypesDir, subdirectory: "Library", forClass: AMLibraryCompiler.self) {
			srcfile = srcdir.appending(component: srcname)
		} else {
			cons.error(string: "[Error] No resource directory for \(srcname).\n")
			return .fileError
		}
	@unknown default:
		cons.error(string: "[Error] Unknown application type.\n")
		return .fileError
	}

	let dstname = srcname
	let dstfile = conf.packageDirectory.appending(component: TypesDir + "/\(dstname)")
	if FileManager.default.copyFile(sourceFile: srcfile, destinationFile: dstfile, doReplace: true){
		return nil
	} else {
		return .fileError
	}
}

private func checkApplication(makefile make: Makefile, manifest mani: Manifest, application appval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let srcfile = appval.toString() else {
		cons.error(string: "[Error] The application property must have string.\n")
		return .parseError
	}
	let scrurl = conf.packageDirectory.appending(path: srcfile)
	guard FileManager.default.fileExists(atURL: scrurl) else {
		cons.error(string: "[Error] The application file is not found: " + srcfile + "\n")
		return .fileError
	}
	switch scrurl.pathExtension {
	case "ts":
		make.addUserTypeScriptFile(file: srcfile)
		let dstfile = replacePathExtension(fileName: srcfile, to: ".js")
		mani.setApplicationScript(file: dstfile)
	default:
		// set to new manifest
		mani.setApplicationScript(file: srcfile)
	}
	return nil
}

private func checkProperties(makefile make: Makefile, manifest mani: Manifest, properties propval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let srcprops = propval.toDictionary() else {
		cons.error(string: "[Error] The properties must have dictionary.\n")
		return .parseError
	}
	for (name, srcprop) in srcprops {
		guard let srcdict = srcprop.toDictionary() else {
			cons.error(string: "[Error] The property must have dictionary.\n")
			return .parseError
		}

		/* type file */
		let typefile: String
		switch fileInDictionary(source: srcdict, key: "type", config: conf) {
		case .success(let file):
			typefile = file
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}
		let typepath = conf.packageDirectory.appending(path: typefile)

		/*  data file */
		let datafile: String
		switch fileInDictionary(source: srcdict, key: "data", config: conf) {
		case .success(let file):
			datafile = file
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}
		let datapath = conf.packageDirectory.appending(path: datafile)

		/* allocate property */
		if let err = checkProperties(makefile: make, manifest: mani, propertyName: name, typeFile: typepath, dataFile: datapath, config: conf, console: cons) {
			return err
		} else { // no errors
			mani.setProperties(name: name, file: Manifest.DataFile(typeFile: typefile, dataFile: datafile))
		}
	}

	return nil // no error
}


private func checkViews(makefile make: Makefile, manifest mani: Manifest, views viewsval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let views = viewsval.toDictionary() else {
		cons.error(string: "[Error] The views property must be dictionary.\n")
		return .parseError
	}

	for (viewname, srcval) in views {
		guard let srcfile = srcval.toString() else {
			cons.error(string: "[Error] The view property \(viewname) must have file name.\n")
			return .parseError
		}
		let srcurl = conf.packageDirectory.appending(path: srcfile)
		guard FileManager.default.fileExists(atURL: srcurl) else {
			cons.error(string: "[Error] The view file is not found: " + srcfile + "\n")
			return .fileError
		}
		switch srcurl.pathExtension {
		case "as":
			make.addArisiaScriptFile(file: srcfile)
			let dstfile = replacePathExtension(fileName: srcfile, to: ".js")
			mani.setView(name: viewname, file: dstfile)
		case "js":
			mani.setView(name: viewname, file: srcfile)
		default:
			cons.error(string: "[Error] The file with extension \(srcurl.pathExtension) is not supported as view.\n")
			return .dataError
		}
	}
	return nil
}

private func checkDefinitions(makefile make: Makefile, manifest mani: Manifest, definitions defsval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let defs = defsval.toArray() else {
		cons.error(string: "[Error] The definitions property must be array.\n")
		return .parseError
	}

	for defval in defs {
		guard let srcfile = defval.toString() else {
			cons.error(string: "[Error] The defines property must have file name.\n")
			return .parseError
		}
		let srcurl = conf.packageDirectory.appending(path: srcfile)
		guard FileManager.default.fileExists(atURL: srcurl) else {
			cons.error(string: "[Error] The definition file is not found: " + srcfile + "\n")
			return .fileError
		}
		guard let srcscr = srcurl.loadContents() as? String else {
			cons.error(string: "[Error] Failed to load contents in " + srcfile + "\n")
			return .fileError
		}
		let tparser = CNValueTypeParser()
		switch tparser.parse(source: srcscr) {
		case .success(_):
			break
		case .failure(let err):
			cons.error(string: "[Error] Failed to parse type definition in \(srcurl.path) (\(err.toString())\n")
			return .fileError
		}
		mani.addDefinition(name: srcfile)
	}
	return nil
}

private func checkLibraries(makefile make: Makefile, manifest mani: Manifest, libraries libsval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let libs = libsval.toArray() else {
		cons.error(string: "[Error] The libraries property must have array.\n")
		return .parseError
	}
	for srcval in libs {
		guard let srcfile = srcval.toString() else {
			cons.error(string: "[Error] The library must have file name.\n")
			return .parseError
		}
		let srcurl = conf.packageDirectory.appending(path: srcfile)
		guard FileManager.default.fileExists(atURL: srcurl) else {
			cons.error(string: "[Error] The library file is not found: " + srcfile + "\n")
			return .fileError
		}
		switch srcurl.pathExtension {
		case "ts":
			make.addLibraryTypeScriptFile(file: srcfile)
			let dstfile = replacePathExtension(fileName: srcfile, to: ".js")
			mani.addLibrary(name: dstfile)
		case "js":
			mani.addLibrary(name: srcfile)
		default:
			cons.error(string: "[Error] The file with extension \(srcurl.pathExtension) is not supported as library.\n")
			return .dataError
		}
	}
	return nil
}

private func checkThreads(makefile make: Makefile, manifest mani: Manifest, threads threadsval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let threads = threadsval.toDictionary() else {
		cons.error(string: "[Error] The threads property must be dictionary.\n")
		return .parseError
	}

	for (threadname, srcval) in threads {
		guard let srcfile = srcval.toString() else {
			cons.error(string: "[Error] The thread property \(threadname) must have file name.\n")
			return .parseError
		}
		let srcurl = conf.packageDirectory.appending(path: srcfile)
		guard FileManager.default.fileExists(atURL: srcurl) else {
			cons.error(string: "[Error] The thread file is not found: " + srcfile + "\n")
			return .fileError
		}
		switch srcurl.pathExtension {
		case "ts":
			make.addUserTypeScriptFile(file: srcfile)
			let dstfile = replacePathExtension(fileName: srcfile, to: ".js")
			mani.setThread(name: threadname, file: dstfile)
		case "js":
			mani.setThread(name: threadname, file: srcfile)
		default:
			cons.error(string: "[Error] The file with extension \(srcurl.pathExtension) is not supported as thread.\n")
			return .dataError
		}
	}
	return nil
}

private func checkImages(makefile make: Makefile, manifest mani: Manifest, images imgsval: CNValue, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let images = imgsval.toDictionary() else {
		cons.error(string: "[Error] The images property must be dictionary.\n")
		return .parseError
	}

	for (imgname, srcval) in images {
		guard let srcfile = srcval.toString() else {
			cons.error(string: "[Error] The image property \(imgname) must have file name.\n")
			return .parseError
		}
		let srcurl = conf.packageDirectory.appending(path: srcfile)
		guard FileManager.default.fileExists(atURL: srcurl) else {
			cons.error(string: "[Error] The image file is not found: " + srcfile + "\n")
			return .fileError
		}
		mani.setImage(name: imgname, file: srcfile)
	}
	return nil
}

private func checkProperties(makefile make: Makefile, manifest mani: Manifest, propertyName pname: String, typeFile tfile: URL, dataFile dfile: URL, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	let iftype: CNInterfaceType
	switch loadInterfaceType(file: tfile) {
	case .success(let typ):
		iftype = typ
	case .failure(let err):
		cons.error(string: "[Error] " + err.toString() + "\n")
		return .parseError
	}

	let propvals: Dictionary<String, CNValue>
	switch loadValue(file: dfile) {
	case .success(let val):
		if let dval = val.toDictionary() {
			propvals = dval
		} else {
			cons.error(string: "[Error] Dictionary value is required for properties")
			return .parseError
		}
	case .failure(let err):
		cons.error(string: "[Error] " + err.toString() + "\n")
		return .parseError
	}

	/* load property data */
	let prop = CNValueProperties(type: iftype)
	if let err = prop.load(value: propvals, from: dfile.path()) {
		cons.error(string: "[Error] " + err.toString() + "\n")
		return .parseError
	}

	return nil
}

private func checkTables(makefile make: Makefile, manifest mani: Manifest, tables tblsval: CNValue, applicationType atype: CNApplicationType, config conf: Config, console cons: CNConsole) -> CNErrorCode?
{
	guard let tables = tblsval.toDictionary() else {
		cons.error(string: "[Error] The tables property must be dictionary.\n")
		return .parseError
	}

	for (tblname, tblval) in tables {
		guard let tbldict = tblval.toDictionary() else {
			cons.error(string: "[Error] The tables record must have dictionary.\n")
			return .parseError
		}

		let typefile: String
		switch fileInDictionary(source: tbldict, key: "type", config: conf) {
		case .success(let name):
			typefile = name
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}
		let typepath = conf.packageDirectory.appending(path: typefile)

		let recif: CNInterfaceType
		switch loadInterfaceType(file: typepath) {
		case .success(let iftype):
			recif = iftype
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}

		let dataname: String
		switch fileInDictionary(source: tbldict, key: "data", config: conf) {
		case .success(let name):
			dataname = name
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}
		let dataurl = conf.packageDirectory.appending(path: dataname)

		let recvals: Array<CNValue>
		switch loadValue(file: dataurl) {
		case .success(let val):
			if let aval = val.toArray() {
				recvals = aval
			} else {
				cons.error(string: "[Error] The table data must contain record value array in \(dataurl.path()).\n")
				return .parseError
			}
		case .failure(let err):
			cons.error(string: "[Error] " + err.toString() + "\n")
			return .parseError
		}

		/* load table data */
		let table = CNValueTable(recordType: recif)
		if let err = table.load(value: recvals, from: dataurl.path()) {
			cons.error(string: "[Error] Failed to load data in \(dataurl.path()). \(err.toString())\n")
			return .parseError
		}
		/* Add data type file to definition */
		mani.addDefinition(name: typefile)
		mani.setTable(name: tblname, file: Manifest.DataFile(typeFile: typefile, dataFile: dataname))
	}
	return nil
}

private func fileInDictionary(source src: Dictionary<String, CNValue>, key keystr: String, config conf: Config) -> Result<String, NSError> {
	guard let data = src[keystr] else {
		let err = NSError.fileError(message: "No \"\(keystr)\" property")
		return  .failure(err)
	}
	guard let file = data.toString() else {
		let err = NSError.fileError(message: "The \"\(keystr)\" property is not string")
		return  .failure(err)
	}
	let filepath = conf.packageDirectory.appending(path: file)
	guard FileManager.default.fileExists(atURL: filepath) else {
		let err = NSError.fileError(message: "[Error] The file is not found: " + file + "\n")
		return .failure(err)
	}
	return .success(file)
}

private func loadInterfaceType(file fl: URL) -> Result<CNInterfaceType, NSError> {
	guard let contents = fl.loadContents() as? String else {
		let err = NSError.fileError(message: "Failed to load contents from \(fl.path())")
		return .failure(err)
	}
	let parser = CNValueTypeParser()
	switch parser.parse(source: contents) {
	case .success(let types):
		if types.count == 1 {
			switch types[0] {
			case .interfaceType(let iftype):
				return .success(iftype)
			default:
				let err = NSError.parseError(message: "Failed to parse type definition in \(fl.path())")
				return .failure(err)
			}
		} else {
			let err = NSError.parseError(message: "Only 1 type definition is required in \(fl.path())")
			return .failure(err)
		}
	case .failure(let err):
		return .failure(err)
	}
}

private func loadValue(file fl: URL) -> Result<CNValue, NSError> {
	guard let content = fl.loadContents() as? String else {
		let err = NSError.fileError(message: "Failed to load contents from \(fl.path())")
		return .failure(err)
	}
	let parser = CNValueParser()
	switch parser.parse(source: content) {
	case .success(let val):
		return .success(val)
	case .failure(let err):
		return .failure(err)
	}
}

private func makeDirectory(directoryPath dpath: String, config conf: Config, console cons: CNConsole) -> Bool {
	let dir = conf.packageDirectory.appending(component: dpath)
	if !FileManager.default.fileExists(atURL: dir) {
		if let err = FileManager.default.createDirectories(directory: dir) {
			cons.error(string: "[Error] Failed to create \"\(dpath)\" directory: \(err.toString())\n")
			return false
		}
	}
	return true
}

private func save(fileName fname: String, text txt: CNText, config conf: Config, console cons: CNConsole) -> CNErrorCode? {
	let file = conf.packageDirectory.appending(component: fname)
	if file.save(string: txt.toStrings(indent: 0).joined(separator: "\n") + "\n") {
		return nil // no error
	} else {
		cons.error(string: "[Error] Failed to create save file: \(file.path())\n")
		return .fileError
	}
}

private func save(fileName fname: String, strings strs: Array<String>, config conf: Config, console cons: CNConsole) -> CNErrorCode? {
	let file = conf.packageDirectory.appending(component: fname)
	if file.save(string: strs.joined(separator: "\n") + "\n") {
		return nil // no error
	} else {
		cons.error(string: "[Error] Failed to create save file: \(file.path())\n")
		return .fileError
	}
}



