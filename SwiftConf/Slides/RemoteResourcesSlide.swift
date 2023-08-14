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
		.extend()
	}
	
	var script: String {
"""
Obviously there's no rule that our closures have to be synchronous
By adding an environment value that contains an async closure, we can create a way to fetch remote resources
I'm going to create a simple one for loading images
Now, my view can execute this task and fetch the image
Because we are using a responder chain, we can add more responders that will try to serve the event first
For example, we can add a responder that will look for the image in the asset catalog
"""
	}
}

struct RemoteResourcesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			RemoteResourcesSlide()
		}
	}
}

