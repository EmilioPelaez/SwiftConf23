//
//  MotivationSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 10/8/23.
//

import SlideKit
import SwiftUI

struct MotivationSlide: Slide {
	var body: some View {
		HeaderSlide("Motivation") {
			Element("Sending data/messages between components in an app is a common challenge")
				.padding(.bottom, 10)
			Element("We create full architectures about it")
				.padding(.bottom, 10)
			Element("This is not an architecture talk")
				.padding(.bottom, 10)
			Element("We're going to explore the tools available out of the box")
				.padding(.bottom, 10)
			Element("We're also going to find interesting ways of using them")
				.padding(.bottom, 10)
		}
		.extend()
	}
}

struct MotivationSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			MotivationSlide()
		}
	}
}

