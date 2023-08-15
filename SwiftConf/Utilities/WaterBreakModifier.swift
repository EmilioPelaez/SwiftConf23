//
//  WaterBreakModifier.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SwiftUI

struct WaterBreakModifier: ViewModifier {
	@EnvironmentObject var container: PresentationState
	
	func body(content: Content) -> some View {
		content
			.background {
				Button {
					container.waterBreak.toggle()
				} label: {
					Text("Hello")
						.opacity(0.01)
				}
				.keyboardShortcut(.upArrow, modifiers: [])
			}
			.overlay {
				if container.waterBreak {
					WaterDrops()
						.allowsHitTesting(false)
				}
			}
	}
}
