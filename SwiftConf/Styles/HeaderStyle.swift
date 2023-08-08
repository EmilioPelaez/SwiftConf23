//
//  HeaderStyle.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct HeaderStyle: HeaderSlideStyle {
	func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			configuration.header
				.font(.system(size: 90))
				.padding(.vertical, 80)
				.frame(maxWidth: .infinity, alignment: .center)
				.foregroundColor(.accentColor)
			VStack(alignment: .leading, spacing: 90) {
				configuration.content
					.font(.system(size: 48))
			}
		}
		.padding(.horizontal, 48)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
