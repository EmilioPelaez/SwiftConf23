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
		.overlay(alignment: .topTrailing) {
			Image("Emilio")
				.resizable()
				.frame(width: 400, height: 400)
				.clipShape(Circle())
				.padding(.top, 48)
				.padding(.trailing, 100)
		}
	}
}

struct IntroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			IntroSlide()
		}
	}
}
