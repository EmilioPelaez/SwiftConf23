//
//  ColorSchemeInverter.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct ColorSchemeInverter: ViewModifier {
	@EnvironmentObject var container: ColorSchemeContainer
	
	func body(content: Content) -> some View {
		content
			.background {
				Button(action: container.toggle) {
					Text("Hello")
				}
				.keyboardShortcut("t")
			}
	}
}

struct ColorSchemeProvider: ViewModifier {
	@EnvironmentObject var container: ColorSchemeContainer
	
	func body(content: Content) -> some View {
		content
			.preferredColorScheme(container.colorScheme)
			.environment(\.codeTheme, container.codeTheme)
			.background(container.backgroundColor)
	}
}

class ColorSchemeContainer: ObservableObject {
	@Published var colorScheme: ColorScheme = .light
	@Published var backgroundColor: Color = .white
	@Published var codeTheme: CodeColorTheme = .presentation
	
	func toggle() {
		switch colorScheme {
		case .light:
			colorScheme = .dark
			backgroundColor = .black
			codeTheme = .defaultDark
		case .dark:
			colorScheme = .light
			backgroundColor = .white
			codeTheme = .presentation
		@unknown default:
			fatalError()
		}
	}
}