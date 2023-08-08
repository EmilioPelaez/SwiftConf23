//
//  UpstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct UpstreamSlide: Slide {
	var body: some View {
		HeaderSlide("Sending Data Upstream") {
			
		}
	}
}

struct UpstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			UpstreamSlide()
		}
	}
}
