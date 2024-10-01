/**
 * @file	config..swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Cobalt
import Foundation

private let ApplicationName = "mkjspkg"

public class Config
{
	private var mPackageDirectory:	URL
	private var mVerboseMode:	Bool

	public var packageDirectory: URL { get { return mPackageDirectory }}
	public var isVerboseMode: Bool { get { return mVerboseMode }}

	public init(packageDirectory pdir: URL, isVerboseMode vmode: Bool){
		mPackageDirectory = pdir
		mVerboseMode      = vmode
	}
}

public class CommandLineParser
{
	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Verbose		= 2
	}

	private var mConsole:	CNConsole

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: \(ApplicationName) [options] package-directory-name (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: \(ApplicationName) [options] " +
		"package-directory-name\n" +
		"  [options]\n" +
		"    --help, -h         : Print this message\n" +
		"    --version          : Print version\n" +
		"    --verbose          : Set verbose mode ON\n"
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
		let stream  = CNArrayStream(source: args)
		var package: URL? = nil
		var verbose       = false
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
					case .Verbose:
						verbose = true
					}
				} else {
					mConsole.error(string: "[Error] Unknown command line option id\n")
				}
			} else if let param = arg as? CBNormalArgument {
				if let url = package {
					mConsole.error(string: "The package directory " +
						       "is already given: \(url.path)\n")
					return nil
				} else {
					package = paramToPackageDir(param: param.argument)
				}
			} else {
				mConsole.error(string: "[Error] Unknown command line parameter: \(arg)\n")
				return nil
			}
		}
		if let url = package {
			return Config(packageDirectory: url, isVerboseMode: verbose)
		} else {
			mConsole.error(string: "[Error] Package directory is not given\n")
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
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func paramToPackageDir(param name: String) -> URL? {
		let url = URL(filePath: name)
		guard FileManager.default.fileExists(atPath: url.path) else {
			mConsole.error(string: "[Error] file is not exist: \(url.path)\n")
			return nil
		}
                var result: URL? = nil
		switch FileManager.default.checkFileType(pathString: url.path) {
                case .success(let ftype):
                        switch ftype {
                        case .directory:
                                result = url
                        case .file:
                                mConsole.error(string: "[Error] The file is NOT directory: \(url.path)\n")
                        @unknown default:
                                mConsole.error(string: "[Error] Internal error: \(url.path)\n")
                        }

                case .failure(let err):
                        mConsole.error(string: "[Error] " + err.toString() + "\n")
		}
                return result
	}

	private func printVersionMessage() {
                var version = "unknown"
                if let plist   = CNPropertyList.loadFromBundle(name: "ArisiaTools.bundle") {
                        version = plist.versionString
                }
		mConsole.print(string: "\(version)\n")
	}
}

