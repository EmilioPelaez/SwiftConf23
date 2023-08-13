//
//  CodeThemeEnvironment.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 13/8/23.
//

import SlideKit
import SwiftUI

struct CodeThemeKey: EnvironmentKey {
	static var defaultValue: CodeColorTheme = .presentation
}

public extension EnvironmentValues {
	var codeTheme: CodeColorTheme {
		get { self[CodeThemeKey.self] }
		set { self[CodeThemeKey.self] = newValue }
	}
}
