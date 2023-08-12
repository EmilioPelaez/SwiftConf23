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
				.padding(.top, 10)
			configuration.child
				.padding(.leading, 90)
		}
		.font(.system(size: 45, weight: .regular, design: .default))
		.fontDesign(.rounded)
		.foregroundStyle(.secondary)
	}
}
