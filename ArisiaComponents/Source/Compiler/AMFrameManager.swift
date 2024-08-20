/**
 * @file	AMFrameManager.swift
 * @brief	Define AMFrameManager class
 * @par Copyright
 *   Copyright (C) 2023 Steel Wheels Project
 */

import ArisiaLibrary
import KiwiEngine
import CoconutData
import Foundation

public extension ALFrameManager
{
	func importBuiltinComponents() {
		if self.hasAllocator(className: AMButton.ClassName) {
			return // already imported
		}

		let components: Dictionary<String,  ALFrameConstructor> = [
			AMButton.ClassName: 	AMButton.constructor,
			AMBox.ClassName:	AMBox.constructor,
            AMCheckBox.ClassName: AMCheckBox.constructor,
			AMCollection.ClassName:	AMCollection.constructor,
			AMConsole.ClassName:	AMConsole.constructor,
			AMImage.ClassName:	AMImage.constructor,
			AMIconView.ClassName:	AMIconView.constructor,
			AMLabel.ClassName: 	AMLabel.constructor,
			AMListView.ClassName:	AMListView.constructor,
			AMPopupMenu.ClassName:	AMPopupMenu.constructor,
			AMProperties.ClassName:	AMProperties.constructor,
			AMRadioButtons.ClassName: AMRadioButtons.constructor,
			AMShell.ClassName:	AMShell.constructor,
			AMSprite.ClassName:	AMSprite.constructor,
			AMStepper.ClassName:	AMStepper.constructor,
			AMTableData.ClassName:	AMTableData.constructor,
			AMTableView.ClassName:	AMTableView.constructor,
			AMTerminal.ClassName:	AMTerminal.constructor,
			AMTextEdit.ClassName:	AMTextEdit.constructor,
			AMTextField.ClassName:	AMTextField.constructor,
			AMTimer.ClassName:	AMTimer.constructor,
		]
		/* register to frame manager and type manager */
		for (name, cnst) in components {
			self.addAllocator(className: name, constructor: cnst)
			/* By calling this method, the type will be registered
			 * into CNValueTypeManager
			 */
			let _ = cnst.baseInterface()
		}
	}
}


