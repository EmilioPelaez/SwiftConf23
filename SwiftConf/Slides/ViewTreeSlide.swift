//
//  ViewTreeSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ViewTreeSlide: Slide {
	var body: some View {
		HeaderSlide("Understanding the View Tree") {
			Element("SwiftUI uses a tree-like structure to define your application's interface")
			Element("Views are directly connected to immediate ancestors and descendants")
			Element("Views have an indirect connection to their ancestors and descendants")
			Element("Views don't have a connection to their siblings and cousins")
		}
	}
}

struct ViewTreeSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ViewTreeSlide()
		}
	}
}
