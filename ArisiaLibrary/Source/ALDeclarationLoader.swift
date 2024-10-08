/**
 * @file	ALDeclarationLoaderswift
 * @brief	Define ALDeclarationLoader class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import CoconutData
import Foundation

public class ALDeclarationLoader
{
	public static func loadDeclaration() -> Result<CNTextSection, NSError> {
		if let url = CNFilePath.URLForResourceFile(fileName: "ArisiaLibrary.d", fileExtension: "ts", subdirectory: "Library/types", forClass: ALDeclarationLoader.self) {
			if let content = url.loadContents() as? String {
				let lines  = content.components(separatedBy: "\n")
				let result = CNTextSection()
				for line in lines {
					result.add(text: CNTextLine(string: line))
				}
				return .success(result)
			} else {
				let err = NSError.fileError(message: "Failed to load from ArisiaLibrary.d.ts")
				return .failure(err)
			}
		} else {
			let err = NSError.fileError(message: "The library file is not found: ArisiaLibrary.d.ts")
			return .failure(err)
		}
	}
}

