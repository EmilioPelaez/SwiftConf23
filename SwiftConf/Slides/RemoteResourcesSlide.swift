//
//  RemoteResourcesSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct RemoteResourcesSlide: Slide {
	var body: some View {
		HeaderSlide("Remote Resources") {
			Element("A similar pattern can be used to centralize resource retrieval")
		}
	}
}

struct RemoteResourcesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			RemoteResourcesSlide()
		}
	}
}

