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
		Item("Wrap Up")
	}
}

struct WrapUpSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			WrapUpSlide()
		}
	}
}

