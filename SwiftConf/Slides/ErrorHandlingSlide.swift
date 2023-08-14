//
//  ErrorHandlingSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ErrorHandlingSlide: Slide {
	var body: some View {
		HeaderSlide("Error Handling") {
			Element("The Responder Chain pattern can be used to centralize error handling")
			Element("Create handlers")
			Element("Create environment value")
		}
		.extend()
	}
	
	var script: String {
"""
We can use this pattern to centralize our error handling
Sometimes, when an error happens, all we can do is show an alert
Since this happens often, we end up with repeated code in many of our views


"""
	}
}

struct ErrorHandlingSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ErrorHandlingSlide()
		}
	}
}

