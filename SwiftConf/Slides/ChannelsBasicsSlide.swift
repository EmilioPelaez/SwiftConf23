//
//  ChannelsBasics.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 14/8/23.
//

import SlideKit
import SwiftUI

struct ChannelsBasicsSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case arguments, bindings, closures
		static var initial: SlidePhasedState { .arguments }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Communication Channels: The Basics") {
			Element("Init Parameters") {
				Callout("Single-level communication")
			}
			if phasedStateStore.after(.bindings) {
				Element("Bindings") {
					Callout("")
				}
			}
			if phasedStateStore.after(.closures) {
				Element("Closures") {
					Callout("Multi-level communication")
					Callout("Key-Value Store")
					Callout("Defining them requires a default value")
					Callout("Values will flow downwards until replaced")
				}
			}
		}
		.extend()
	}
	
	var script: String {
"""
I'm going to start with the easiest and most obvious way of passing data down the view hierarchy, init parameters
These are pretty trivial, you use them as soon as you start making an app
They allow us to pass data down one level
And obviously we can keep passing the data deeper and deeper but that requires explicit declarations every level
If we want to send data back up the hierarchy, we can combine it with a binding

A binding will enable a child view to update a value and its parent will receive the new value
This mechanism is used everywhere in SwiftUI
It's one of the ways we can use to share data between siblings and cousins
We can pass a binding from a common ancestor to different branches of our tree
Any updates to that binding from any of the views will be reflected in all the views that observe it
Then we have another mechanism to pass data and events up the hierarchy, and it's a core feature of Swift, closures

Just like we would with a binding, we can pass a closure to allow descendant views to execute a function defined higher in the hierarchy

"""
	}
}

struct ChannelsSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsBasicsSlide()
		}
	}
}
