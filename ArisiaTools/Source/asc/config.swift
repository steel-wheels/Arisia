/**
 * @file	config..swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiEngine
import CoconutData
import Cobalt
import Foundation

public class Config
{
	public enum Format {
		case TypeScript
		case TypeDeclaration
	}

        private var mApplicationType:   CNApplicationType
	private var mScriptFile: 	String
	private var mPackageDirectory:	URL?
	private var mImportFiles:	Array<String>
	private var mOutputFormat:	Format

        public var applicationType: CNApplicationType   { get { return mApplicationType    }}
	public var scriptFile: String		        { get { return mScriptFile		}}
	public var packageDirectory: URL?	        { get { return mPackageDirectory	}}
	public var importFiles: Array<String> 	        { get { return mImportFiles		}}
	public var outputFormat: Format		        { get { return mOutputFormat		}}


        public init(applicationType atype: CNApplicationType, scriptFile file: String, packageDirectory packdir: URL?, importFiles ifiles: Array<String>, outputFormat form: Format){
                mApplicationType        = atype
		mScriptFile		= file
		mPackageDirectory	= packdir
		mImportFiles 		= ifiles
		mOutputFormat		= form
	}

	public func outputFileName() -> Result<String, NSError> {
		let ext: String
		switch mOutputFormat {
		case .TypeScript:	ext = ".ts"
		case .TypeDeclaration:	ext = ".frame.d.ts"
		}
		return replaceFileName(sourceFile: mScriptFile, extension: ext)
	}

	public func _frameFileName() -> Result<String, NSError> {
		return replaceFileName(sourceFile: mScriptFile, extension: ".frame.d.ts")
	}

	private func replaceFileName(sourceFile src: String, extension ext: String) -> Result<String, NSError> {
		let nsstr: NSString = src as NSString
		let newname = nsstr.lastPathComponent.replacingOccurrences(of: ".as", with: ext)
		if newname != src {
			return .success(newname)
		} else {
			return .failure(NSError.fileError(message: "Failed to get destination file name from \(src)"))
		}
	}
}

public class CommandLineParser
{
	public typealias Format = Config.Format

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Import 		= 2
		case Format		= 3
		case Target		= 4
		case Package		= 5
	}

	private var mConsole:	CNConsole

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: asc [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: asc [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --format, -f <lang>   : The output format: \"JavaScript\" (default),\n" +
		"                            \"TypeScript\" or \"TypeDeclaration\"\n" +
		"    --import, -I <file>   : The .d.ts file to import\n" +
		"    --target, -t <targ>   : The target design: \"terminal\" (default) or\n" +
		"                            \"window\"\n" +
		"    --package, -p <dir>   : The package directory which contains the source script\n" +
		"    --help, -h            : Print this message\n" +
		"    --version             : Print version\n"
		)
	}

	public func parseArguments(arguments args: Array<String>) -> (Config, Array<String>)? {
		var config : Config? = nil
		let (err, _, rets, subargs) = CBParseArguments(parserConfig: parserConfig(), arguments: args)
		if let e = err {
			mConsole.error(string: "[Error] \(e.description)\n")
		} else {
			config = parseOptions(arguments: rets)
		}
		if let config = config {
			return (config, subargs)
		} else {
			return nil
		}
	}

	private func parseOptions(arguments args: Array<CBArgument>) -> Config? {
		var srcfile: String?		= nil
		var format:  Format		= .TypeScript
		var imports: Array<String>	= []
		var target:  CNApplicationType	= .terminal
		var package: URL?		= nil
		let stream   			= CNArrayStream(source: args)
		while let arg = stream.get() {
			if let opt = arg as? CBOptionArgument {
				if let optid = OptionId(rawValue: opt.optionType.optionId) {
					switch optid {
					case .Help:
						printHelpMessage()
						return nil
					case .Version:
						printVersionMessage()
						return nil
					case .Import:
						switch parseImport(values: opt.parameters) {
						case .success(let files):
							imports.append(contentsOf: files)
						case .failure(let err):
							mConsole.error(string: "[Error] \(err.toString())")
							return nil
						}
					case .Format:
						if let form = parseFormat(values: opt.parameters) {
							format = form
						} else {
							return nil
						}
					case .Target:
						if let targ = parseTarget(values: opt.parameters) {
							target = targ
						} else {
							return nil
						}
					case .Package:
						if let pdir = parsePackage(values: opt.parameters) {
							package = pdir
						} else {
							return nil
						}
					}
				} else {
					mConsole.error(string: "[Error] Unknown command line option id")
				}
			} else if let param = arg as? CBNormalArgument {
				if srcfile == nil {
					srcfile = param.argument
				} else {
					mConsole.error(string: "[Error] You can not give multiple source files")
					return nil
				}
			} else {
				mConsole.error(string: "[Error] Unknown command line parameter: \(arg)")
				return nil
			}
		}
		if let file = srcfile {
                        return Config(applicationType: target, scriptFile: file, packageDirectory: package, importFiles: imports, outputFormat: format)
		} else {
			mConsole.error(string: "[Error] The souce file name is required\n")
			return nil
		}
	}

	private func parserConfig() -> CBParserConfig {
		let opttypes: Array<CBOptionType> = [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Print version information"),
			CBOptionType(optionId: OptionId.Import.rawValue,
				     shortName: "I", longName: "import",
				     parameterNum: 1, parameterType: .stringType,
				     helpInfo: "Import .d.ts file"),
			CBOptionType(optionId: OptionId.Format.rawValue,
				     shortName: "f", longName: "format",
				     parameterNum: 1, parameterType: .stringType,
				     helpInfo: "The format of output file"),
			CBOptionType(optionId: OptionId.Target.rawValue,
				     shortName: "t", longName: "target",
				     parameterNum: 1, parameterType: .stringType,
				     helpInfo: "The design of target component"),
			CBOptionType(optionId: OptionId.Package.rawValue,
				     shortName: "p", longName: "package",
				     parameterNum: 1, parameterType: .stringType,
				     helpInfo: "The package directory")
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func parseImport(values vals: Array<CBValue>) -> Result<Array<String>, NSError> {
		var result: Array<String> = []
		for val in vals {
			switch val {
			case .stringValue(let str):
				result.append(str)
			case .doubleValue(_), .intValue(_):
				return .failure(NSError.parseError(message: "String parameter is required: \(val.description)"))
			@unknown default:
				return .failure(NSError.parseError(message: "Unexpected parameter is required: \(val.description)"))
			}
		}
		return .success(result)
	}

	private func parseFormat(values vals: Array<CBValue>) -> Format? {
		let result: Format?
		switch vals.count {
		case 1:
			if let form = parseFormat(value: vals[0]) {
				result = form
			} else {
				mConsole.print(string: "[Error] Give parameter \"JavaScript\" or \"TypeScript\" for language option")
				result = nil
			}
		case 0:
			mConsole.print(string: "[Error] Give parameter \"JavaScript\" or \"TypeScript\" for language option")
			result = nil
		default:
			mConsole.print(string: "[Error] Too many parameter for language option")
			result = nil
		}
		return result
	}

	private func parseFormat(value val: CBValue) -> Format? {
		let result: Format?
		switch val {
		case .stringValue(let str):
			switch str {
			case "TypeScript":	result = .TypeScript
			case "TypeDeclaration":	result = .TypeDeclaration
			default:
				mConsole.print(string: "[Error] Unexpected format: \(str)")
				result = nil
			}
		default:
			result = nil
		}
		return result
	}

	private func parseTarget(values vals: Array<CBValue>) -> CNApplicationType? {
		let result: CNApplicationType?
		switch vals.count {
		case 1:
			if let form = parseTarget(value: vals[0]) {
				result = form
			} else {
				mConsole.print(string: "[Error] Give parameter \"JavaScript\" or \"TypeScript\" for language option")
				result = nil
			}
		case 0:
			mConsole.print(string: "[Error] Give parameter \"JavaScript\" or \"TypeScript\" for language option")
			result = nil
		default:
			mConsole.print(string: "[Error] Too many parameter for language option")
			result = nil
		}
		return result
	}

	private func parseTarget(value val: CBValue) -> CNApplicationType? {
		let result: CNApplicationType?
		switch val {
		case .stringValue(let str):
			switch str {
			case "terminal":	result = .terminal
			case "window":		result = .window
			default:
				mConsole.error(string: "[Error] Unexpected target: \(str)")
				result = nil
			}
		default:
			result = nil
		}
		return result
	}

	private func parsePackage(values vals: Array<CBValue>) -> URL? {
		let result: URL?
		switch vals.count {
		case 1:
			switch vals[0] {
			case .stringValue(let path):
				switch FileManager.default.checkFileType(pathString: path) {
                                case .success(let ftype):
                                        switch ftype {
                                        case .directory:
                                                result = URL(filePath: path)
                                        case .file:
                                                mConsole.print(string: "[Error] Given file is NOT directory: \(path)")
                                                result = nil
                                        @unknown default:
                                                mConsole.print(string: "[Eror] Internal error")
                                                result = nil
                                        }
                                case .failure(let err):
                                        mConsole.print(string: err.toString())
                                        result = nil
				}
			default:
				mConsole.print(string: "[Error] String parameter for package name is required")
				result = nil
			}
		default:
			mConsole.print(string: "[Error] Too many parameter for package directory")
			result = nil
		}
		return result
	}

	private func printVersionMessage() {
                var version: String = "unknown"
                if let plist = CNPropertyList.loadFromBundle(name: "ArisiaTools.bundle") {
                        version = plist.versionString
                }
		mConsole.print(string: "\(version)\n")
	}
}
