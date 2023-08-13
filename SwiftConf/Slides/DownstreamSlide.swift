//
//  DownstreamSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct DownstreamSlide: Slide {
	
	enum SlidePhasedState: Int, PhasedState {
		case arguments, environmentObjects, environmentValues
		static var initial: SlidePhasedState { .arguments }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Sending Data Downstream") {
			Element("init Parameters") {
				Callout("Single-level communication")
				Callout("One-way*")
			}
			if phasedStateStore.after(.environmentObjects) {
				Element("Environment Objects") {
					Callout("Multi-level communication")
					Callout("Two-way")
				}
			}
			if phasedStateStore.after(.environmentValues) {
				Element("Environment Values") {
					Callout("Key-Value Store")
					Callout("Defining them requires a default value")
					Callout("Values will flow downwards until replaced")
					Callout("One-way*")
				}
			}
		} extra: {
			switch phasedStateStore.current {
			case .arguments:
				Code(code, colorTheme: .presentation, fontSize: 30).frame(maxWidth: .infinity, alignment: .leading)
			case .environmentObjects:
				Image("MOO").prepare().padding(.top, 50)
			case .environmentValues:
				Code(code, colorTheme: .presentation, fontSize: 30)
			}
		}
	}
	
	var code: String {
"""
struct MyView: View {
	
	let value: Int
	
	init(value: Int) {
		self.value = value
	}
	
	var body: some View {
		Text("Value \\(value)")
	}
}
"""
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .arguments:
"""
Parameters are trivial so I won't spend too much time on them
You can use them to send data down one level
Obviously you can send it deeper but each level requires explicit declaration
They are a one-way channel
There are some exceptions, we'll talk about them in the next slide
We're going to move on to Environment Objects
"""
		case .environmentObjects:
"""
These are very easy to use and very powerful
They allow us to encapsulate logic in a class
We're a lot more familiar with classes
Classes are a lot more testable
But it's easy to overuse environment objects
I'm sure many of us have put way too much logic into an environment object
Now we're gonna talk about one of my favorite SwiftUI features, Environment Values
"""
		case .environmentValues:
"""
Environment Values are the feature that powers many view modifiers
It works as a key-value store that is propagated to the whole view hierarchy
We can inject values for these keys at any level we want
These values will only be available from that level and downwards
Any higher levels will use the previous value
A cool thing about environment values is that they are defined with a default value
Unlike environment objects, they work without injecting any value explicitly
They will default to the default value
Something else I like is that they are very atomic, they are very composable
When you observe and environment value, you can't change it
You can only publish new values downstream
So it's a one-way communication channel but there's exceptions
"""
		}
	}
}

struct DownstreamSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			DownstreamSlide()
		}
	}
}

struct MyView: View {
	
	let value: Int
	
	init(value: Int) {
		self.value = value
	}
	
	var body: some View {
		Text("Value \(value)")
	}
}
