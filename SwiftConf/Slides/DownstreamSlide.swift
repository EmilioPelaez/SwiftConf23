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
		Item("Downstream")
	}
}

struct DownstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			DownstreamSlide()
		}
	}
}

