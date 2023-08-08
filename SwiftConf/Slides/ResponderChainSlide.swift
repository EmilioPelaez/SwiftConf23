//
//  ResponderChainSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ResponderChainSlide: Slide {
	var body: some View {
		Item("Responder Chain")
	}
}

struct ResponderChainSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ResponderChainSlide()
		}
	}
}

