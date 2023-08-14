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
		HeaderSlide("The Responder Chain") {
			
		}
		.extend()
	}
	
	var script: String {
"""
A responder chain is a design pattern where we have a number of connected objects
Each one of this links is called a responder, and it has the potential to respond to an arbitrary event
They way it works is by giving an event to one of the responders of the chain, usually the first responder
If that term sounds familiar it's because this pattern also exists in UIKit
That responder determines if it can respond to the event
If it can, the event is consumed
If it cannot, the event is passed to the next responder, who does the same thing
This goes on until the event is consumed or it reaches the end
Depending on the implementation, it may fail silently or throw an error
"""
	}
}

struct ResponderChainSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ResponderChainSlide()
		}
	}
}

