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
			Element("The environment is opaque")
			Element("Find a balance between using the environment and other methods")
		}
	}
}

struct WrapUpSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			WrapUpSlide()
		}
	}
}

