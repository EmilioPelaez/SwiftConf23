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
		case bindings, environmentObjects, preferenceKeys
		static var initial: SlidePhasedState { .bindings }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Downstream, Upstream and... Sidestream?") {
			Element("Bindings and Closures") {
				Callout("Single-level communication")
			}
			if phasedStateStore.after(.environmentObjects) {
				Element("Environment Objects") {
					Callout("Hello again")
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
			Color.white
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .bindings:
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
