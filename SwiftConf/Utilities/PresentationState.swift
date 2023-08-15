//
//  PresentationState.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SlideKit
import SwiftUI

class PresentationState: ObservableObject {
	@Published var colorScheme: ColorScheme = .light
	@Published var backgroundColor: Color = .white
	@Published var codeTheme: CodeColorTheme = .presentation
	@Published var invertImages = false
	
	@Published var waterBreak = false
	
	func toggle() {
		switch colorScheme {
		case .light:
			colorScheme = .dark
			backgroundColor = .black
			codeTheme = .defaultDark
			invertImages = true
		case .dark:
			colorScheme = .light
			backgroundColor = .white
			codeTheme = .presentation
			invertImages = false
		@unknown default:
			fatalError()
		}
	}
}
