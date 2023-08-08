//
//  OutroSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct OutroSlide: Slide {
	var body: some View {
		HeaderSlide("Thank you!") {
			
		}
	}
}

struct OutroSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			OutroSlide()
		}
	}
}

