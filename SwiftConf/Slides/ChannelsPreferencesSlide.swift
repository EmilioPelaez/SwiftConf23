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
					Callout("Responders may handle some arbitrary events")
					Callout("If a responder can't handle an event, it's passed along")
				}
			}
		} auxiliary: {
			if phasedStateStore.when(.initial) {
				Image("Environment")
					.prepare()
					.scaleEffect(.init(width: 1, height: -1))
					.extend(.center)
			}
			if phasedStateStore.when(.preferenceKey) {
				VStack {
					Image("PreferenceKey")
						.prepare()
					Image("Modifiers")
						.prepare()
				}
			}
			if phasedStateStore.when(.responderChain) {
				ResponderChainVisualization()
			}
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .initial:
"""
What if we want to send data back up the view hierarchy

In that case we can use Preferences
Preferences are kind of a reverse environment value mechanism
They also work with keys

But with an environment object, the value is published up in the hierarchy
And observed below

With Preferences, the value is updated below
And observed above
"""
		case .preferenceKey:
"""
I find these very intriguing for a few reasons

The first is taht name Preferences doesn't make it super obvious what the functionality is supposed to be

If you look at the PreferenceKey protocol, only one public type conforms to it
When you look at the documentation for that type it says "Don’t use this"

And yet there are 11 different view modifiers that you can use to interact with preferences
So it seems like a robust system
But they don't give us enough keys to play with it

I think that SwiftUI should provide more preference keys out of the box
A useful one would be a preference key to read the scroll offset of a scroll view

In fact, many of these modifiers make references to the layout system
One of the most common uses for preferences you'll see is to read the size of a child view

I'm going to get a bit theoretical
The way environment values and preferences are implemented follow a design pattern called responder chain
"""
		case .responderChain:
"""
A responder chain is a pattern where we have a number of connected objects
Each one of this objects is called a responder because it has the potential to respond to an arbitrary event

They way we use it is by giving an event to one of the responders of the chain
This responder determines if it can respond to the event
If it can, the event is consumed
If it can't, the event is passed to the next responder, who does the same thing

This goes on until the event is consumed or it reaches the end
Depending on the implementation, it may fail silently or throw an error

Responders are not limited to just handling an event or not
They can also modify the event or replace it with a completely different one

Preferences are really useful to send layout values up the view hierarchy
But what if we wanted to do something similar for events?

Let's see how we can do that using environment values
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
