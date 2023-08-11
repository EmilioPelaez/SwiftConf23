//
//  DownstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct DownstreamSlide: Slide {
	var body: some View {
		HeaderSlide("Passing Data Downstream") {
			Element("Arguments")
			Element("Environment Objects")
			Element("Environment values")
			Element("Data in the environment will flow downwards until it's replaced")
		}
	}
}

struct DownstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			DownstreamSlide()
		}
	}
}

