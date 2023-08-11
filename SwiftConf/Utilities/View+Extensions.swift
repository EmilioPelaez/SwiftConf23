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
	
	func imageOverlay(_ image: String) -> some View {
		overlay(alignment: .topTrailing) {
			Image(image)
				.resizable()
				.frame(width: 400, height: 400)
				.clipShape(Circle())
//				.padding(.top, 48)
				.padding(.trailing, 100)
		}
	}
}
