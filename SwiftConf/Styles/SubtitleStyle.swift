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
		VStack(alignment: .leading, spacing: 25) {
			configuration.label
			configuration.child
				.padding(.leading, 90)
		}
		.font(.system(size: 60, weight: .medium, design: .default))
		.foregroundStyle(.primary)
	}
}
