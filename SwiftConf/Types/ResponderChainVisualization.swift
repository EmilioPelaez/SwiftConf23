//
//  ResponderChainVisualization.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SwiftUI

struct ResponderChainVisualization: View {
	var body: some View {
		VStack(alignment: .center) {
			Circle()
				.foregroundStyle(.red)
				.overlay(alignment: .leading) {
					HStack(spacing: 0) {
						Text("Event")
							.foregroundStyle(.white)
							.font(.system(size: 30))
							.frame(width: 110)
							.padding(.vertical, 4)
							.background {
								Capsule()
									.foregroundStyle(.blue)
							}
						Image(systemName: "arrow.right")
					}
					.offset(x: -145)
				}
			Image(systemName: "arrow.down")
			Circle()
				.foregroundStyle(.green)
			Image(systemName: "arrow.down")
			Circle()
				.foregroundStyle(.blue)
			Image(systemName: "arrow.down")
			Circle()
				.foregroundStyle(.yellow)
		}
		.font(.largeTitle)
		.frame(width: 250)
	}
}

#Preview {
	ResponderChainVisualization()
}
