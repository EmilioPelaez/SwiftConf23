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
			Element("A design pattern")
			Element("Consists of a chain of responders (duh)")
			Element("The chain receives an event in one of its nodes")
			Element("The responder determines if it can respond to the event or not")
			Element("If it can respond, the event is consumed")
			Element("If it can't respond, the event is passed up the chain")
			Element("If it reaches the end, it fails or throws an error")
		}
		.extend()
	}
	
	var script: String {
"""
A responder chain is a design pattern
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

