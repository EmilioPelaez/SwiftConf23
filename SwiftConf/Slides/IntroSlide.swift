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
		HeaderSlide("The View Hierarchy as a Communication Channel") {
			Subtitle("Emilio Peláez")
			Content("Mobile Engineering Director @ Modus Create")
		}
	}
}

struct IntroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			IntroSlide()
		}
	}
}
