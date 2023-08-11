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
		HeaderSlide("Sending Data Upstream") {
			Element("Bindings")
			Element("Environment Objects")
			Element("Preference Keys")
			Element("Only one Preference Key defined in SwiftUI")
			Element("Many modifiers that allow transformation of preference keys")
			Element("Preference Keys are a responder chain")
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
