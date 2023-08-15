//
//  ChannelsPreferences.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 14/8/23.
//

import SlideKit
import SwiftUI

struct ChannelsPreferencesSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case initial, preferenceKey, responderChain
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Communication Channels: Preferences") {
			Element("What are they?") {
				Callout("\"Reverse\" Environment Values")
			}
			if phasedStateStore.after(.preferenceKey) {
				Element("PreferenceKey Protocol") {
					Callout("Only one public type conforms to it")
					Callout("But don't use it!")
					Callout("Almost a dozen modifiers")
				}
			}
			if phasedStateStore.after(.responderChain) {
				Element("Responder Chains") {
					Callout("Chain of connected responders")
					Callout("Responders may or may not handle arbitrary events")
					Callout("If a responder can't handle an event, it's passed along")
				}
			}
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .initial:
"""
If we want to send values up the view hierarchy we can use Preferences
Preferences are kind of a reverse environment value
They also work with keys but you update it's value deeper in the hierarchy and observe it's value above
"""
		case .preferenceKey:
"""
I find these very intriguing because if you look at the PreferenceKey protocol, only one public type conforms to it
If you look at the documentation it says "Don’t use this"
And yet there are 11 different view modifiers that you can use to interact with preferences
I believe that SwiftUI should provide more preference keys out of the box, like a scroll view offset
The name Preferences in my opinion doesn't make it super obvious what is it that they do
One of the most common usages for preferences I've seen is to read the size of a child view
If we look at the available modifiers we can see they behave differently to environment values
Preferences follow a pattern called a responder chain
"""
		case .responderChain:
"""
A responder chain is a design pattern where we have a number of connected objects
Each one of this objects is called a responder because it has the potential to respond to an arbitrary event
They way we use it is by giving an event to one of the responders of the chain
That responder determines if it can respond to the event
If it can, the event is consumed
If it cannot, the event is passed to the next responder, who does the same thing
This goes on until the event is consumed or it reaches the end
Depending on the implementation, it may fail silently or throw an error
Responders are not limited to just responding or not, they can also modify the event or send a different one

The responder chain is one of my favorite design patterns because it's very flexible and modular
I asked myself how can I build a responder chain that works not just with values but with events?
"""
		}
	}
}

struct ChannelsPreferencesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsPreferencesSlide()
		}
	}
}
