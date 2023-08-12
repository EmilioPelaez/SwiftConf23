//
//  MoreEnvironmentValuesSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct MoreEnvironmentValuesSlide: Slide {
	var body: some View {
		HeaderSlide("Fancy Environment Values") {
			Element("Environment values are usually structs, but we can also pass closures")
			Element("callAsFunction")
			Element("Using a pattern similar to preference keys we can transform events")
		}
		.extend()
	}
}

struct MoreEnvironmentValuesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			MoreEnvironmentValuesSlide()
		}
	}
}

