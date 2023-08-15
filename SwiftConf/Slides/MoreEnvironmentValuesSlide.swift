//
//  MoreEnvironmentValuesSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct MoreEnvironmentValuesSlide: Slide {
	@Environment(\.codeTheme) var codeTheme
	
	enum SlidePhasedState: Int, PhasedState {
		case environment, modifier, examples
		static var initial: SlidePhasedState { .environment }
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Responders in the Environment") {
			Code(code(for: phasedStateStore.current), colorTheme: codeTheme, fontSize: 28)
				.extend()
		} auxiliary: {
			Image("Matrix")
				.prepare()
		}
	}
	
	func code(for state: SlidePhasedState?) -> String {
		guard let state else { return "" }
		switch state {
		case .environment:
			return """
struct TriggerEvent {
	let execute: (Any) -> Void
	
	func callAsFunction(_ event: Any) {
		execute(event)
	}
}

// let trigger = TriggerEvent { _ in }
// trigger.execute("Hello")
// trigger("Hello")

struct TriggerEventKey: EnvironmentKey {
	static var defaultValue: TriggerEvent = .init { _ in print("Unhandled Event") }
}

extension EnvironmentValues {
	var triggerEvent: TriggerEvent {
		get { self[TriggerEventKey.self] }
		set { self[TriggerEventKey.self] = newValue }
	}
}
"""
		case .modifier:
			return """
struct EventHandlerModifier: ViewModifier {
	@Environment(\\.triggerEvent) var triggerEvent
	
	let handler: (Any) -> Any?
	
	func body(content: Content) -> some View {
		content.environment(\\.triggerEvent, TriggerEvent {
			if let event = handler($0) {
				triggerEvent(event)
			}
		})
	}
}

extension View {
	func receiveEvent(_ handler: @escaping (Any) -> Any?) -> some View {
		modifier(EventHandlerModifier(handler: handler))
	}
}
"""
		case .examples:
			return """
struct CoolEvent {}

struct CoolView: View {
	@Environment(\\.triggerEvent) var triggerEvent
	
	var body: some View {
		Button("😎🏄🏽‍♂️😎") {
			triggerEvent(CoolEvent())
		}
	}
}

struct CoolModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				if event is CoolEvent {
					print("😎🏄🏽‍♂️😎")
					return nil
				} else {
					return event
				}
			}
	}
}
"""
		}
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .environment:
"""
We'll start by creating a struct that contains a closure

Environment values are expected to be value types, but closures are reference types
That's why we wrap our closure in a struct

We're using callAsFunction as the name of the function because it allows us to call a value as if it was a function
In the example here it allows us to skip the .execute
It's just syntactic sugar
If you look at the DismissAction that SwiftUI uses, it does the same thing

Our closure takes a value of Any type because our event can be anything we want

Next we'll need to create an environment key and we'll give it a default value
It will print a message in case the event wasn't handled
Then we extend EnvironmentValues to add our own key

Now that we have our environment value we need a view modifier that can act as a link
"""
		case .modifier:
"""
We're going to create a view modifier that reads the value from the environment, and also publishes its own value

This modifier will take a handler as a parameter
This handler will be a closure that will be responsible for determining if it can handle the event

To use it we're going to pass the event to the handler
If the handler returns nil it means the event was handled and consumed
The handler can also return something, either the same event or a new one
If it does, we send that event up the view hierarhy

Finally we'll add a view extension to make it easy to use

Now let's see at how we can use this
"""
		case .examples:
"""
First create a custom type that will be our event

Then in one of our views we're going to read the envionment value
We're going to call it as a function when something happens
In this case it will be when we press this really cool button

We'll use a view modifier to receive the event

This view modifier has to be added higher in the view hierarchy

If the received event is a CoolEvent, we're going to print a message and consume the event
If it's anything else we're just going to pass that along

Now let's see a more practical use
"""
		}
	}
}

struct MoreEnvironmentValuesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			MoreEnvironmentValuesSlide()
		}
	}
}

struct TriggerEvent {
	let execute: (Any) -> Void
	
	func callAsFunction(_ event: Any) {
		execute(event)
	}
}

// let trigger = TriggerEvent { _ in }
// trigger("Hello")
// trigger.execute("Hello")

struct TriggerEventKey: EnvironmentKey {
	static var defaultValue: TriggerEvent = .init { _ in print("Unhandled Event") }
}

extension EnvironmentValues {
	var triggerEvent: TriggerEvent {
		get { self[TriggerEventKey.self] }
		set { self[TriggerEventKey.self] = newValue }
	}
}

struct EventHandlerModifier: ViewModifier {
	@Environment(\.triggerEvent) var triggerEvent
	
	let handler: (Any) -> Any?
	
	func body(content: Content) -> some View {
		content.environment(\.triggerEvent, TriggerEvent {
			if let event = handler($0) {
				triggerEvent(event)
			}
		})
	}
}

extension View {
	func receiveEvent(_ handler: @escaping (Any) -> Any?) -> some View {
		modifier(EventHandlerModifier(handler: handler))
	}
}

struct CoolEvent {}

struct CoolView: View {
	@Environment(\.triggerEvent) var triggerEvent
	
	var body: some View {
		Button("😎🏄🏽‍♂️😎") {
			triggerEvent(CoolEvent())
		}
	}
}

struct CoolModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				if event is CoolEvent {
					print("😎🏄🏽‍♂️😎")
					return nil
				} else {
					return event
				}
			}
	}
}
