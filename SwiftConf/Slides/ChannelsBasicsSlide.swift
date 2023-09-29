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
		case arguments, bindings, observables, closures
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
					Callout("Wraps a value to allow a child to modify it")
				}
			}
			if phasedStateStore.after(.observables) {
				Element("Observable Objects") {
					Callout("Encapsulates logic and values into a class")
				}
			}
			if phasedStateStore.after(.closures) {
				Element("Closures") {
					Callout("AKA Annonymous Functions")
					Callout("The Swift feature we all know and love")
				}
			}
		} auxiliary: {
			Image("Basics")
				.prepare()
		}
		.extend()
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .arguments:
"""
I'm going to start with the easiest and most obvious way of passing data down the view hierarchy, init parameters
These are pretty trivial, you use them as soon as you start making an app

They allow us to pass data down one level
Obviously we can keep passing the data deeper and deeper but that requires explicit declarations every level
"""
		case .bindings:
"""
Another core mechanism of SwiftUI are bindings

A binding is a wrapper for a value that you can pass to a child view
The child view can modify the value, and the parent will receive the updated value

Just like with init parameters, we can pass this down as many levels as we want
But it requires an explicit declaration every time

This mechanism is used widely in SwiftUI by components like switches and text fields

It's one of the ways we can use to share data between siblings and cousins
We can pass a binding from a common ancestor to different branches of our tree
Any updates to that binding from any of the views will be reflected in all the other views that observe it
"""
		case .observables:
"""
They allow us to encapsulate logic and values into a class and share that with multiple views
The nice thing about classes is that they have a more straight-forward life cycle than views and they are a lot more testable

A downside of observable objects is that any change to any of its values will trigger a reevaluation of all the views that observe them
But with the new Observation framework in iOS 17 this is no longer an issue
"""
		case .closures:
"""
A closure is an annonymous function

By passing a closure to a child view, that child can execute an action that was defined higher in the view hierarchy

A good example is a SwiftUI button
Which will execute a closure when it's tapped

These are a bit trivial, they are the basics after all
"""
		}
	}
}

struct ChannelsSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsBasicsSlide()
		}
	}
}
