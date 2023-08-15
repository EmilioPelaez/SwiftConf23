//
//  InvertedEnvironment.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SwiftUI

struct InvertImagesKey: EnvironmentKey {
	static var defaultValue: Bool = false
}

public extension EnvironmentValues {
	var invertImages: Bool {
		get { self[InvertImagesKey.self] }
		set { self[InvertImagesKey.self] = newValue }
	}
}

