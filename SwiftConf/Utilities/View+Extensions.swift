//
//  ViewExtensions.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 11/8/23.
//

import SwiftUI

extension View {
	func extend(_ alignment: Alignment = .top) -> some View {
		frame(maxHeight: .infinity, alignment: alignment)
	}
}
