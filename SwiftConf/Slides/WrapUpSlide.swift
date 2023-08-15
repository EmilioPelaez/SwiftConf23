//
//  WrapUpSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct WrapUpSlide: Slide {
	var body: some View {
		HeaderSlide("Wrapping Up") {
			VStack(alignment: .leading, spacing: 50) {
				Element("All views in a SwiftUI app are connected") {
					Callout("Via the View Hierarchy!")
				}
				Element("The View Hierarchy has multiple communication channels") {
					Callout("The Environment")
					Callout("Preferences")
				}
				Element("The Environment and Preferences are very flexible") {
					Callout("At the cost of having no compile-time safety")
				}
			}
			.extend(.center)
		} auxiliary: {
			Image("Wrap")
				.prepare()
		}
	}
	
	var script: String {
"""
All the views in a SwiftUI app are connected to each other through the view hierarchy or view tree
This view hierarchy has multiple communication channels that we can leverage to share data and messages between any two views in our application
The environment and preference channels are very flexible and modular, but that comes at the cost of not having compile-time safety
"""
	}
}

struct WrapUpSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			WrapUpSlide()
		}
	}
}
