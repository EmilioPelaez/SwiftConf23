//
//  DownstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct DownstreamSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case arguments, environmentObjects, environmentValues
		static var initial: DownstreamSlide.SlidePhasedState { .arguments }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Sending Data Downstream") {
			Element("init Parameters") {
				Callout("Single-level communication")
				Callout("One-way*")
			}
			if phasedStateStore.after(.environmentObjects) {
				Element("Environment Objects") {
					Callout("Multi-level communication")
					Callout("Two-way")
				}
			}
			if phasedStateStore.after(.environmentValues) {
				Element("Environment Values") {
					Callout("Key-Value Store")
				}
			}
		} extra: {
			switch phasedStateStore.current {
			case .arguments:
				Code(code, colorTheme: .presentation, fontSize: 30).frame(maxWidth: .infinity, alignment: .leading)
			case .environmentObjects:
				Image("MOO").prepare().padding(.top, 50)
			case .environmentValues:
				Code(code, colorTheme: .presentation, fontSize: 30)
			}
		}
	}
	
	var code: String {
"""
struct MyView: View {
	
	let value: Int
	
	init(value: Int) {
		self.value = value
	}
	
	var body: some View {
		Text("Value \\(value)")
	}
}
"""
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .arguments:
"""
Parameters are trivial so we won't spend too much time on them
You can use them to send data down one level
Obviously you can send it deeper but it requires adding a parameter to each view
It's one way because the child cannot send a value back (with exceptions)
"""
		case .environmentObjects:
"""
Not as trivial but really common and easy to use

"""
		case .environmentValues:
"""
"""
		}
	}
}

struct DownstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			DownstreamSlide()
		}
	}
}

struct MyView: View {
	
	let value: Int
	
	init(value: Int) {
		self.value = value
	}
	
	var body: some View {
		Text("Value \(value)")
	}
}
