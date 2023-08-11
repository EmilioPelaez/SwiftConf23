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
				.font(.system(size: 90, weight: .regular, design: .rounded))
				.padding(.bottom, 20)
				.foregroundStyle(.primary)
			configuration.content
		}
		.padding(48)
		.frame(maxWidth: .infinity, alignment: .leading)
	}
}
