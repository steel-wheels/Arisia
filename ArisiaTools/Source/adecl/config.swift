/**
 * @file	config..swift
 * @brief	Define Config class
 * @par Copyright
 *   Copyright (C) 2022 Steel Wheels Project
 */

import KiwiEngine
import CoconutData
import Cobalt
import Foundation

public class Config
{
	public var doIsolate: Bool

	public init(doIsolate iso: Bool){
		doIsolate	= iso
	}
}

public class CommandLineParser
{
	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Isolate		= 2
	}

	private var mConsole:	CNConsole

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func printUsage() {
		mConsole.print(string: "usage: adecl [options] [frame-name] (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: adecl [options]\n" +
		"  [options]\n" +
		"    --help, -h         : Print this message\n" +
		"    --version          : Print version\n" +
		"    --isolate, -i      : Generate type declaration file for each classes\n"
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
		var isolate	= false
		let stream	= CNArrayStream(source: args)
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
					case .Isolate:
						isolate = true
					}
				} else {
					mConsole.error(string: "[Error] Unknown command line option id")
				}
			} else if let _ = arg as? CBNormalArgument {
				/* ignore */
			} else {
				mConsole.error(string: "[Error] Unknown command line parameter: \(arg)")
				return nil
			}
		}
		return Config(doIsolate: isolate)
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
			CBOptionType(optionId: OptionId.Isolate.rawValue,
				     shortName: "i", longName: "isolate",
				     parameterNum: 0, parameterType: .voidType,
				     helpInfo: "Generate isolated type declaration file for each classes")
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
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

	private func printVersionMessage() {
                var version = "unknown"
                if let plist = CNPropertyList.loadFromBundle(name: "ArisiaTools.bundle") {
                        version = plist.versionString
                }
		mConsole.print(string: "\(version)\n")
	}
}
