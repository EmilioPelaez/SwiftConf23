//
//  IntroSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct IntroSlide: Slide {
	var body: some View {
		Item("Intro")
	}
}

struct IntroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			IntroSlide()
		}
	}
}
