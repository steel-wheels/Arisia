/**
 * @file	makefile..swift
 * @brief	Define Makefile class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import KiwiEngine
import Foundation

public class Makefile
{
	private var mApplicationType:		KEApplicationType
	private var mUserTypeScriptFiles:	Array<String>
	private var mLibTypeScriptFiles:	Array<String>
	private var mLibTypeDeclarationFiles:	Array<String>
	private var mArisiaScriptFiles:		Array<String>
	private var mToolPath:			String

	public init(applicationType atype: KEApplicationType){
		mApplicationType		= atype
		mUserTypeScriptFiles		= []
		mLibTypeScriptFiles		= []
		mLibTypeDeclarationFiles	= []
		mArisiaScriptFiles		= []
		mToolPath			= "/usr/local/libexec/arisia/bin"
	}

	public static func libraryDecrationFileName(applicationType atype: KEApplicationType) -> String {
		let KiwiLibraryDeclarationFile		= "KiwiLibrary.d.ts"
		let ArisiaComponentDeclarationFile	= "ArisiaComponents.d.ts"

		let result: String
		switch atype {
		case .terminal:
			result = KiwiLibraryDeclarationFile
		break
		case .window:
			result = ArisiaComponentDeclarationFile
		break
		@unknown default:
			CNLog(logLevel: .error, message: "Library declaration file name is not known", atFunction: #function, inFile: #file)
			result = KiwiLibraryDeclarationFile
		}
		return result
	}

	public static func componentFileName() -> String {
		return "ArisiaComponent.d.ts"
	}

	public func addUserTypeScriptFile(file fl: String){
		mUserTypeScriptFiles.append(fl)
	}

	public func addLibraryTypeScriptFile(file fl: String){
		mLibTypeScriptFiles.append(fl)
	}

	public func addLibraryTypeDeclarationFile(file fl: String){
		mLibTypeDeclarationFiles.append(fl)
	}

	public func addArisiaScriptFile(file fl: String){
		mArisiaScriptFiles.append(fl)
	}

	public func toScript() -> CNText {
		let result = CNTextSection()

		/* header */
		let header: Array<String> = [
			"#",
			"# Makefile",
			"#",
			""
		]
		appendScript(section: result, lines: header)

		/* command definitions */
		let arisiaCompiler	= "asc"
		let arisiaDeclarator	= "asdecl"
		let typeScriptCompiler	= "tsc"
		let typeScriptOptions	= "tsc_opt"
		let jsrunCommand	= "jsrun"
		let commands: Array<String> = [
			"\(arisiaCompiler)\t= \(mToolPath)/asc",
			"\(arisiaDeclarator)\t= \(mToolPath)/adecl",
			"",
			"\(typeScriptCompiler)\t= npx tsc",
			"\(typeScriptOptions)\t= -t ES2017 --lib \"es2017\" --declaration --declarationDir ./types \\",
			"\t  --alwaysStrict --strict --strictNullChecks --pretty",
			"",
			"\(jsrunCommand)\t= \(mToolPath)/jsrun",
			""
		]
		appendScript(section: result, lines: commands)

		/* command line options for "asc" command */
		var ascOptions = "asc_opt ="
		for tsfile in mLibTypeScriptFiles {
			let fpath = tsfile as NSString
			let fname = fpath.lastPathComponent.deletingPathExtension
			let dname = "types/" + fname + ".d.ts"
			ascOptions += " -I \(dname)"
		}
		appendScript(section: result, lines: [ascOptions, ""])

		/* rules */
		let rules: Array<String> = [
			"# *.as -> *.ts, *.d.ts",
			"%.ts: %.as",
			"\t$(\(arisiaCompiler)) --target window -f TypeScript $(asc_opt) $<",
			"\t$(\(arisiaCompiler)) --target window -f TypeDeclaration $(asc_opt) $<",
			"\tmv $(<:.as=.frame.d.ts) types/",
			"",
			"# *.js -> *.ts",
			"%.js: %.ts",
			"\t$(\(typeScriptCompiler)) $(\(typeScriptOptions)) $<",
			"",
		]
		appendScript(section: result, lines: rules)

		/* source files */
		let arisiaSource		= "assrcs"
		let userTypeScriptSource	= "utssrcs"
		let libTypeScriptSource		= "ltssrcs"
		var arisiaSourceFiles		= ""
		for file in mArisiaScriptFiles {
			arisiaSourceFiles = arisiaSourceFiles + " " + file
		}
		var userTypeScriptSourceFiles = ""
		for file in mUserTypeScriptFiles {
			userTypeScriptSourceFiles = userTypeScriptSourceFiles + " " + file
		}
		var libTypeScriptSourceFiles = ""
		for file in mLibTypeScriptFiles {
			libTypeScriptSourceFiles = libTypeScriptSourceFiles + " " + file
		}
		let srcfiles: Array<String> = [
			"# source files",
			"\(arisiaSource)\t= \(arisiaSourceFiles)",
			"\(userTypeScriptSource)\t= \(userTypeScriptSourceFiles)",
			"\(libTypeScriptSource)\t= \(libTypeScriptSourceFiles)",
			""
		]
		appendScript(section: result, lines: srcfiles)

		/* Destination files */
		let arisiaTypeScriptDestination	= "astsdsts"
		let arisiaJavaScriptDestination	= "asjsdsts"
		let userJavaScriptDestination	= "ujsdsts"
		let libJavaScriptDestination	= "ljsdsts"
		let dstfiles: Array<String> = [
			"# destination files",
			"\(arisiaTypeScriptDestination)\t= $(\(arisiaSource):.as=.ts)",
			"\(arisiaJavaScriptDestination)\t= $(\(arisiaSource):.as=.js)",
			"\(userJavaScriptDestination)\t= $(\(userTypeScriptSource):.ts=.js)",
			"\(libJavaScriptDestination)\t= $(\(libTypeScriptSource):.ts=.js)",
			""
		]
		appendScript(section: result, lines: dstfiles)

		/* main dependences */
		let genDeclTarget    = "gen_decl"
		let libScriptTarget  = "lib_scripts"
		let userScriptTarget = "user_scripts"
		let maindeps: Array<String> = [
			"all: \(genDeclTarget) \(libScriptTarget) \(userScriptTarget)",
			""
		]
		appendScript(section: result, lines: maindeps)

		/* generate declaration file */
		let bdecl = generateBuiltinDeclaration(target: genDeclTarget, adeclCommand: "\(mToolPath)/adecl")
		result.add(text: bdecl)

		/* dependency of library script */
		let lsect = defineScriptDependency(target: libScriptTarget, typeScriptDestination: "",
						  javaScriptDestination: "$(\(libJavaScriptDestination))")
		result.add(text: lsect)

		/* scripts */
		let usect = defineScriptDependency(target: userScriptTarget,
						   typeScriptDestination: "$(\(arisiaTypeScriptDestination))",
						   javaScriptDestination: "$(\(arisiaJavaScriptDestination)) $(\(userJavaScriptDestination))")
		result.add(text: usect)

		/* cleaner */
		let cleandep: Array<String> = [
			"clean:",
			"\trm -f $(\(arisiaTypeScriptDestination)) $(\(arisiaJavaScriptDestination)) $(\(userJavaScriptDestination)) $(\(libJavaScriptDestination))",
			""
		]
		appendScript(section: result, lines: cleandep)

		let dummydep: Array<String> = [
			"dummy:",
			""
		]
		appendScript(section: result, lines: dummydep)

		return result
	}

	private func generateBuiltinDeclaration(target targ: String, adeclCommand adecl: String) -> CNTextSection {
		let result = CNTextSection()
		result.add(text: CNTextLine(string: "\(targ): dummy"))
		result.add(text: CNTextLine(string: "\t(cd types && \(adecl))"))
		result.add(text: CNTextLine(string: ""))
		return result
	}

	private func defineScriptDependency(target targ: String, typeScriptDestination tsdst: String, javaScriptDestination jstst: String) -> CNTextSection {
		let result = CNTextSection()
		let defs: Array<String> = [
			"\(targ): \(tsdst) \(jstst)",
			""
		]
		appendScript(section: result, lines: defs)
		return result
	}

	private func appendScript(section sect: CNTextSection, lines lns: Array<String>){
		for line in lns {
			sect.add(text: CNTextLine(string: line))
		}
	}
}

