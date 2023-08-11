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
			Callout("Questions? Comments?")
			Callout("Follow me on Mastodon")
			Image("MastodonQR")
				.resizable()
				.frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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

