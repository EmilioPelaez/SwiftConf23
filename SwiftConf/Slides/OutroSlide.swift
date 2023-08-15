//
//  OutroSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct OutroSlide: Slide {
	var body: some View {
		HeaderSlide("Thank you!") {
			Callout("Questions? Comments?")
			Callout("Follow me on Mastodon!")
			Callout("Built with SlideKit")
		}
		.imageOverlay("MastodonQR")
		.extend(.center)
		.background {
			ConfettiView()
				.allowsHitTesting(false)
		}
		.overlay(alignment: .bottomLeading) {
			Image("Modus")
				.resizable()
				.frame(width: 107, height: 100)
				.padding(48)
		}
	}
}

struct OutroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			OutroSlide()
		}
	}
}

