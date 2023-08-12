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
			VStack(alignment: .leading, spacing: 50) {
				Element("Sending data and messages between components in an app is a common challenge")
				Element("Whole architectures are created to solve it")
				Element("We're going to explore the tools available in SwiftUI")
				Element("And find interesting ways of using them!")
			}
		} auxiliary: {
			Image("Architecture").prepare()
		}
		.extend()
	}
	
	var script: String {
"""
Sending data/messages between components in an app is a common challenge
We create full architectures about it
This is not an architecture talk
We're going to explore the tools available out of the box
We're also going to find interesting ways of using them
"""
	}
}

struct MotivationSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			MotivationSlide()
		}
	}
}

