//
//  ChannelsEnvironmentSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 14/8/23.
//

import SlideKit
import SwiftUI

struct ChannelsEnvironmentSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case initial, objects, values, extras
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Communication Channels: The Environment") {
			Element("What is it?") {
				Callout("A collection of data that gets propagated to every view in the view hierarchy")
				Callout("Data will flow downwards until replaced")
			}
			if phasedStateStore.after(.objects) {
				Element("Environment Objects") {
					Callout("Very easy to use and powerful")
					Callout("Use classes instead of structs")
				}
			}
			if phasedStateStore.after(.values) {
				Element("Environment Values") {
					Callout("Key-Value Store")
					Callout("Defining them requires a default value")
					if phasedStateStore.after(.extras) {
						Callout("Closures*")
						Callout("Bindings")
					}
				}
			}
		} auxiliary: {
			ZStack {
				Image("Environment")
					.prepare()
					.extend(.center)
				if phasedStateStore.when(.objects) {
					Image("MOO")
						.prepare()
						.padding()
				}
			}
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
			case .initial:
"""
Let's talk about a very powerful feature called the Environment

It's a collection of data that gets passed down the view hierarchy to all the views in our app

Views can inject data into the environment and this data gets propagated to the descendants

There are two main ways of interacting with the Environment
"""
			case .objects:
"""
The first one is by using Environment Objects

These are really easy to use and very powerful
They are also a bit easy to overuse
I'm sure a lot of us have put way too much logic into an environment object and one point or another

They allow us to encapsulate logic and values into a class and share that with multiple views
The nice thing about classes is that they have a more straight-forward life cycle than views and they are a lot more testable

A downside of environment objects is that any change to any of its values will trigger a reevaluation of all the views that observe them
But with the new Observation framework in iOS 17 this is no longer an issue

We can use them to share data in any direction because every view that observes them will reflect any changes
If we want to communicate between sibling or cousin views, all we need to do is to find a common ancestor and inject the environment object there
"""
			case .values:
"""
The other method of interacting with the environment is by using Environment Values

Environment values are basically a key-value store, kind of like a dictionary
That gets passed down the view hierarchy and is accessible to all the views

Views can observe the value for a given key but cannot modify it
What they can do is insert a new value for a key and that value will be available to its descendants

This is the mechanism that is used by many modifiers like font

Something I really like about environment values is that defining one requires you to provide a default value

If you observe an environment object but there's no object in the hierarchy, your preview won't load and your app will crash
If you observe an environment value and haven't provided a value, it will use the default value
"""
		case .extras:
"""
There's a couple of special types that we can add to the environment that behave in interesting ways

The first one is closures
By putting a closure in the environment we can share it with more distant descendents easily
I put an asterisk because Environment Values are expected to be value types
Closures are reference types
This has some performance implications but I'm not going to get into that
What we can do is wrap our closure in a struct, and inject that value instead
We'll talk about that in a bit

The other interesting value we can put in the environment is a binding
This can be pretty handy to allow many views to make many changes to a single value
Kind of a micro environment object

There's a caveat
The default value of a binding is a constant binding
If you fail to inject a live binding your values won't update and you may struggle to find why
"""
		}
	}
}

struct ChannelsEnvironmentSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsEnvironmentSlide()
		}
	}
}
