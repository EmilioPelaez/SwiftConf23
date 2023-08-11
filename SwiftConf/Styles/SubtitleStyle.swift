//
//  SubtitleStyle.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct SubtitleStyle: ItemStyle {
	func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			configuration.label
				.padding(.bottom, 25)
			configuration.child
				.padding(.leading, 90)
		}
		.font(.system(size: 60, weight: .medium, design: .default))
		.foregroundStyle(.primary)
	}
}
