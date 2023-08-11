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
	}
}

struct ErrorHandlingSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ErrorHandlingSlide()
		}
	}
}

