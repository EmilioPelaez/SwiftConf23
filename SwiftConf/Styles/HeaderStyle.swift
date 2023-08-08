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
		VStack(alignment: .leading, spacing: 15) {
			configuration.header
				.font(.system(size: 90, weight: .regular, design: .rounded))
				.padding(.vertical, 40)
				.foregroundStyle(.primary)
			configuration.content
		}
		.padding(.horizontal, 48)
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
	}
}
