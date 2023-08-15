//
//  MoreEnvironmentValuesSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct MoreEnvironmentValuesSlide: Slide {
	var body: some View {
		HeaderSlide("Responders in the Environment") {
			Element("Environment values are usually structs, but we can also pass closures")
			Element("callAsFunction")
			Element("Using a pattern similar to preference keys we can transform events")
		}
		.extend()
	}
	
	var script: String {
"""
Let's see how that would look like
We'll start by creating a type that contains a closure
Environment values are expected to be value types, but closures are reference types
That's why we wrap our closure in a struct
If you look at the DismissAction provided by SwiftUI it does the same thing
We're using callAsFunction as the name of the function because it allows us to omit the function name
Our closure takes a value of Any type because our event can be anything we want
And it returns an optional value because we will return nil when the event is consumed

Now that we have our environment value we need a view modifier that can act as a link
We're going to create a view modifier that reads the value from the environment, and also publishes its own value
The value it's going to publish is going to be a parameter of our view modifier
We add a view extension to make it easier to use

Now we can use the environment value to trigger an event from any view
And any view higher in the view hierarchy can respond to this event
Now let's look at how we can use this
"""
	}
}

struct MoreEnvironmentValuesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			MoreEnvironmentValuesSlide()
		}
	}
}

