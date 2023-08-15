//
//  ColorSchemeInverter.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct ColorSchemeInverter: ViewModifier {
	@EnvironmentObject var container: PresentationState
	
	func body(content: Content) -> some View {
		content
			.background {
				Button(action: container.toggle) {
					Text("Hello")
						.opacity(0.01)
				}
				.keyboardShortcut("t")
			}
	}
}

struct ColorSchemeProvider: ViewModifier {
	@EnvironmentObject var container: PresentationState
	
	func body(content: Content) -> some View {
		content
			.preferredColorScheme(container.colorScheme)
			.environment(\.codeTheme, container.codeTheme)
			.environment(\.invertImages, container.invertImages)
			.background(container.backgroundColor)
	}
}
