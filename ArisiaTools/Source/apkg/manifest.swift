/**
 * @file	manifest..swift
 * @brief	Define Manifest class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import Foundation

public class Manifest {

	public struct DataFile {
		public var typeFile:	String
		public var dataFile:	String

		public init(typeFile typef: String, dataFile dataf: String) {
			self.typeFile = typef
			self.dataFile = dataf
		}
	}

	private var mApplicationScript:	String?
	private var mProperties:	Dictionary<String, DataFile>
	private var mViewScripts:	Dictionary<String, String>
	private var mDefinitionFiles:	Array<String>
	private var mLibearyScripts:	Array<String>
	private var mThreadScripts:	Dictionary<String, String>
	private var mImageFiles:	Dictionary<String, String>
	private var mTableFiles:	Dictionary<String, DataFile>

	public init(){
		mApplicationScript	= nil
		mProperties		= [:]
		mViewScripts		= [:]
		mDefinitionFiles	= []
		mLibearyScripts		= []
		mThreadScripts		= [:]
		mImageFiles		= [:]
		mTableFiles		= [:]
	}

	public func setApplicationScript(file fl: String){
		mApplicationScript = fl
	}

	public func setProperties(name nm: String, file fl: DataFile){
		mProperties[nm] = fl
	}

	public func setView(name nm: String, file fl: String){
		mViewScripts[nm] = fl
	}

	public func addDefinition(name nm: String){
		mDefinitionFiles.append(nm)
	}

	public func addLibrary(name nm: String){
		mLibearyScripts.append(nm)
	}

	public func setThread(name nm: String, file fl: String){
		mThreadScripts[nm] = fl
	}

	public func setImage(name nm: String, file fl: String){
		mImageFiles[nm] = fl
	}

	public func setTable(name nm: String, file fl: DataFile){
		mTableFiles[nm] = fl
	}

	public func toScript() -> CNText {
		var root: Dictionary<String, CNValue> = [:]

		if let app = mApplicationScript {
			root["application"] = .stringValue(app)
		}
		if let props = makeDataDictionary(source: mProperties) {
			root["properties"] = .dictionaryValue(props)
		}

		if let views = makeValueDictionary(source: mViewScripts) {
			root["views"] = .dictionaryValue(views)
		}

		if let defs = makeValueArray(source: mDefinitionFiles) {
			root["definitions"] = .arrayValue(defs)
		}

		if let libs = makeValueArray(source: mLibearyScripts) {
			root["libraries"] = .arrayValue(libs)
		}

		if let threads = makeValueDictionary(source: mThreadScripts) {
			root["threads"] = .dictionaryValue(threads)
		}

		if let images = makeValueDictionary(source: mImageFiles) {
			root["images"] = .dictionaryValue(images)
		}

		if let tables = makeDataDictionary(source: mTableFiles) {
			root["tables"] = .dictionaryValue(tables)
		}

		return CNValue.dictionaryValue(root).toScript()
	}

	private func makeValueArray(source src: Array<String>) -> Array<CNValue>? {
		var result: Array<CNValue> = []
		for elm in src {
			result.append(.stringValue(elm))
		}
		return result.count > 0 ? result : nil
	}

	private func makeValueDictionary(source src: Dictionary<String, String>) -> Dictionary<String, CNValue>? {
		var result: Dictionary<String, CNValue> = [:]
		for (name, file) in src {
			result[name] = .stringValue(file)
		}
		return (result.count > 0) ? result : nil
	}

	private func makeDataDictionary(source src: Dictionary<String, DataFile>) -> Dictionary<String, CNValue>? {
		var result: Dictionary<String, CNValue> = [:]
		for (name, file) in src {
			let tblfile: Dictionary<String, CNValue> = [
				"type": .stringValue(file.typeFile),
				"data": .stringValue(file.dataFile)
			]
			result[name] = .dictionaryValue(tblfile)
		}
		return (result.count > 0) ? result : nil
	}
}
