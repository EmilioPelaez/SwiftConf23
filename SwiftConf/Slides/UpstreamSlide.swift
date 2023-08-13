//
//  UpstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct UpstreamSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case arguments, environmentObjects, preferenceKeys
		static var initial: SlidePhasedState { .arguments }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Sending Data Upstream and... Sidestream?") {
			Element("Bindings and Closures") {
				Callout("Single-level communication")
				Callout("Sidestream!")
			}
			if phasedStateStore.after(.environmentObjects) {
				Element("Environment Objects") {
					Callout("Hello again")
					Callout("Sidestream too!")
				}
			}
			if phasedStateStore.after(.preferenceKeys) {
				Element("Preference Keys") {
					Callout("Only one Preference Key defined in SwiftUI, but don't use it!")
					Callout("Many modifiers that allow interaction with Preference Keys")
					Callout("Preference Keys are a responder chain!")
				}
			}
		} auxiliary: {
			Color.red
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .arguments:
"""
"""
		case .environmentObjects:
"""
"""
		case .preferenceKeys:
"""
"""
		}
	}
}

struct UpstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			UpstreamSlide()
		}
	}
}
