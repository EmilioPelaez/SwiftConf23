//
//  ChannelsEnvironmentSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 14/8/23.
//

import SlideKit
import SwiftUI

struct ChannelsEnvironmentSlide: Slide {
	var body: some View {
		HeaderSlide("Communication Channels: The Environment") {
			Element("What is it?") {
				Callout("A collection of data that gets propagated to every view in the view hierarchy")
				Callout("Data will flow downwards until replaced")
			}
			Element("Environment Objects") {
				Callout("Very easy to use and powerful")
				Callout("Use classes instead of structs")
			}
			Element("Environment Values") {
				Callout("Key-Value Store")
				Callout("Defining them requires a default value")
			}
		}
		.extend()
	}
	
	var script: String {
"""
Up until now we haven't really been using the view hierarchy
SwiftUI has a very powerful feature called the Environment
It's a collection of data that gets passed down the view hierarchy to all the views
When we look at our view tree, instead of this it should look more like this
Views can inject data into the environment and this data gets propagated to the descendants until it's replaced by another view
There are two main ways of interacting with the Environment

The first one is by using Environment Objects
These are really easy to use and very powerful
They are also a bit easy to overuse, I'm sure a lot of us have put way too much logic into an environment object and one point or another
They allow us to encapsulate logic and values into a class and share that with multiple views
The nice thing about classes is that they have a more straight-forward life cycle than views and they are a lot more testable
A downside of environment objects is that any change to any of its values will trigger a reevaluation of all the views that observe them
But with the new Observation framework in iOS 17 this is no longer an issue
We can use them to share data in any direction because every view that observes them will reflect any changes
If we want to communicate between sibling or cousin views, all we need is to find a common ancestor and send the environment object from there

The other method of interacting with the environment is by using Environment Values
This is one of my favorite features of SwiftUI
It is basically a key-value store, kind of like a dictionary, that gets passed down the view hierarchy and is accessible to all the views
Views can observe the value for a given key but cannot modify it
What they can do is insert a new value for a key and that value will be available to the descendants
This is the mechanism that is used by modifiers like font
Which is why you can go to the top of your view hierarchy and apply some modifiers that will affect your whole app
Except for the parts of the tree that have replaced that value
Something I really like about environment values is that defining one requires you to provide a default value
If you observe an environment object but there's no object in the hierarchy, your preview won't load and your app will crash
If you observe an environment value and haven't provided a value, it will use the default value
Environment Values are also very atomic, which makes them very composable
"""
	}
}

struct ChannelsEnvironmentSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsEnvironmentSlide()
		}
	}
}
