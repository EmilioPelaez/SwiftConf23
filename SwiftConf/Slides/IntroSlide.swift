//
//  IntroSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct IntroSlide: Slide {
	var body: some View {
		HeaderSlide("The View Hierarchy as a Communication Channel") {
			Subtitle("Emilio Peláez")
			Callout("iOS Developer since 2008")
			Callout("Mobile Engineering Director @ Modus Create")
		}
		.imageOverlay("Emilio")
		.extend(.center)
		.overlay(alignment: .bottomLeading) {
			Image("Modus")
				.resizable()
				.frame(width: 107, height: 100)
				.padding(48)
		}
	}
}

struct IntroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			IntroSlide()
		}
		.headerSlideStyle(HeaderStyle())
	}
}
