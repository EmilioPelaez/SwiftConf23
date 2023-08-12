//
//  UpstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct UpstreamSlide: Slide {
	var body: some View {
		HeaderSlide("Sending Data Upstream and... Sidestream?") {
			Element("Bindings and Closures") {
				Callout("Single-level communication")
				Callout("Sidestream!")
			}
			Element("Environment Objects") {
				Callout("Hello again")
				Callout("Sidestream too!")
			}
			Element("Preference Keys") {
				Callout("Only one Preference Key defined in SwiftUI, but don't use it!")
				Callout("Many modifiers that allow interaction with Preference Keys")
				Callout("Preference Keys are a responder chain!")
			}
		}
		.extend()
	}
}

struct UpstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			UpstreamSlide()
		}
	}
}
