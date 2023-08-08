//
//  Body.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 9/8/23.
//

import SlideKit
import SwiftUI

struct Body<Child: View>: View {
	
	let text: String
	let child: () -> Child
	
	init(_ text: String, child: @escaping () -> Child) {
		self.text = text
		self.child = child
	}
	
	var body: some View {
		Item(accessory: .none) {
			Text(text)
		} child: {
			child()
		}
		.itemStyle(ContentStyle())
	}
}

extension Body where Child == EmptyView {
	init(_ text: String) {
		self.text = text
		self.child = { EmptyView() }
	}
}
