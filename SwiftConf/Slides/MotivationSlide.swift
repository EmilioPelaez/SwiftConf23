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
			.padding(.bottom, 200)
			.extend(.center)
		} auxiliary: {
			Image("Architecture")
				.prepare()
		}
	}
	
	var script: String {
"""
The motivation for this talk is that one of the earliest challenges developers run into is how to send data between two components in an application
It's such a common challenge that we develop whole architectures to solve it
There's lots of opinions on how it should be done
But I'm not here to convince you to use or not use a specific architecture
Instead we're going to explore the tools available out of the box in SwiftUI
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

