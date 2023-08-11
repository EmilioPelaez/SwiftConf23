//
//  CalloutStyle.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct CalloutStyle: ItemStyle {
	func makeBody(configuration: Configuration) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			configuration.label
				.padding(.bottom, 10)
			configuration.child
				.padding(.leading, 90)
		}
		.font(.system(size: 45, weight: .medium, design: .default))
		.foregroundStyle(.secondary)
	}
}
