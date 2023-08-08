//
//  ColorSchemeInverter.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SwiftUI

struct ColorSchemeInverter: ViewModifier {
	@Environment(\.colorScheme) var colorScheme
	
	let inverted: Bool = true
	
	var scheme: ColorScheme {
		colorScheme.opposite
	}
	
	func body(content: Content) -> some View {
		content
			.preferredColorScheme(.light)
			.background(.white)
	}
}

extension ColorScheme {
	var opposite: ColorScheme {
		switch self {
		case .light: .dark
		case .dark: .light
		case _: .light
		}
	}
	
	var backgroundColor: Color {
		switch self {
		case .light: .white
		case .dark: .black
		case _: .red
		}
	}
}
