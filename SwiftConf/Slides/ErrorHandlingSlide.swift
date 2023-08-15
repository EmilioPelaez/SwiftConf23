//
//  ErrorHandlingSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ErrorHandlingSlide: Slide {
	@Environment(\.codeTheme) var codeTheme
	
	enum SlidePhasedState: Int, PhasedState {
		case initial, errorModifier, analytics, login
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Error Handling") {
			Code(codeLeft, colorTheme: codeTheme, fontSize: 30)
		} extra: {
			Code(codeRight, colorTheme: codeTheme, fontSize: 30)
		}
		.extend()
	}
	
	var codeLeft: String {
		switch phasedStateStore.current {
		case .initial:
"""
struct MainView: View {
	@State var showAlert = false
	@State var error: AuthorizationError?
	
	var body: some View {
		Text("Welcome!")
			.task {
				do {
					try ContentService.loadContent()
				} catch is AuthorizationError {
					self.error = error
					showAlert = true
				} catch {
					print("Something went wrong")
				}
			}
			.alert(isPresented: $showAlert,
						 error: error) {
				Button("Ok") {}
			}
	}
}
"""
		case .errorModifier:
"""
struct MyApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.modifier(ErrorAlertModifier())
		}
	}
}

struct ContentView: View {
	@Environment(\\.triggerEvent) var triggerEvent
	
	var body: some View {
		Text("Welcome")
			.task {
				do {
					try ContentService.loadContent()
				} catch {
					triggerEvent(error)
				}
			}
	}
}
"""
		case .analytics:
"""
struct MyApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.receiveEvent { event in
					if let error = event as? Error {
						AnalyticsService.log(error)
					}
					return event
				}
				.modifier(ErrorAlertModifier())
		}
	}
}
"""
		case .login:
"""
struct MyApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.receiveEvent { event in
					if event is AuthorizationError {
						return ShowLoginEvent()
					} else {
						return event
					}
				}
				.modifier(LoginModifier())
				.receiveEvent { event in
					if let error = event as? Error {
						AnalyticsService.log(error)
					}
					return event
				}
				.modifier(ErrorAlertModifier())
		}
	}
}
"""
		}
	}
	
	var codeRight: String {
		switch phasedStateStore.current {
		case .initial:
"""
"""
		case .errorModifier:
"""
struct ErrorAlertModifier: ViewModifier {
	@State var showAlert = false
	@State var errorMessage: String?
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard let error = event as? LocalizedError else {
					return event
				}
				showAlert = true
				errorMessage = error.localizedDescription
				return nil
			}
			.alert("Uh oh", isPresented: $showAlert) {
				Button("Ok") {}
			} message: {
				Text(errorMessage ?? "Unknown Error")
			}
	}
}
"""
		case .analytics:
"""

"""
		case .login:
"""
struct ShowLoginEvent {}

struct LoginModifier: ViewModifier {
	@State var showLogin = false
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard event is ShowLoginEvent else {
					return event
				}
				showLogin = true
				return nil
			}
			.sheet(isPresented: $showLogin) {
				LoginView()
			}
	}
}
"""
		}
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .initial:
"""
Let's use it to handle some errors

Something that happens often is that a user will encounter an error where all we can do is show an alert

In this view we're trying to load some content and when that fails, we present an alert that just tells the user they are not logged in

But what if instead of having this kind of boilerplate everywhere in our application, we could collect these errors in a single location
"""
		case .errorModifier:
"""
This is a lot of code, but first let's look at the modifier on the right

This modifier is going to be responsible for showing the alert error
It will receive the events, and if the event is a Localized Error, it will show an alert with that error's description

On the bottom left, all our view has to do is read that environment value and call it as a function when an error happens
"""
		case .analytics:
"""
And because the responder chain is so modular, we can easily add more functionality to this

For example, we could add a handler that will log every error that goes through it to our analytics service

In this case, we're not consuming any events at all
"""
		case .login:
"""
Remember we said that a handler can transform an event

Let's imagine that we have a LoginModifier that is responsible for showing the login screen
This modifier is already expecting a ShowLoginEvent
But our view is sending an AuthorizationError

What we can do is add a handler that will look for an AuthorizationError and it will tranform it into a ShowLoginEvent

I want to note here that order really matters
If the login modifier was added before the transformation, this wouldn't work
"""
		}
	}
}

struct ErrorHandlingSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ErrorHandlingSlide()
		}
	}
}

struct AuthorizationError: LocalizedError {
	var errorDescription: String? {
		"Unauthorized"
	}
}

struct MainView: View {
	@State var showAlert = false
	@State var error: AuthorizationError?
	
	var body: some View {
		Text("Welcome!")
			.task {
				do {
					try ContentService.loadContent()
				} catch is AuthorizationError {
					self.error = error
					showAlert = true
				} catch {
					print("Something went wrong")
				}
			}
			.alert(isPresented: $showAlert,
						 error: error) {
				Button("Ok") {}
			}
	}
}

struct ErrorAlertModifier: ViewModifier {
	@State var showAlert = false
	@State var errorMessage: String?
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard let error = event as? LocalizedError else {
					return event
				}
				showAlert = true
				errorMessage = error.localizedDescription
				return nil
			}
			.alert("Uh oh", isPresented: $showAlert) {
				Button("Ok") {}
			} message: {
				Text(errorMessage ?? "Unknown Error")
			}
	}
}

struct ContentView: View {
	@Environment(\.triggerEvent) var triggerEvent
	
	var body: some View {
		Text("Welcome")
			.task {
				do {
					try ContentService.loadContent()
				} catch {
					triggerEvent(error)
				}
			}
	}
}

struct MyApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
				.receiveEvent { event in
					if event is AuthorizationError {
						return ShowLoginEvent()
					} else {
						return event
					}
				}
				.modifier(LoginModifier())
				.receiveEvent { event in
					if let error = event as? Error {
						AnalyticsService.log(error)
					}
					return event
				}
				.modifier(ErrorAlertModifier())
		}
	}
}

struct LoginView: View {
	var body: some View {
		Text("Login")
	}
}

struct ShowLoginEvent {}

struct LoginModifier: ViewModifier {
	@State var showLogin = false
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard event is ShowLoginEvent else {
					return event
				}
				showLogin = true
				return nil
			}
			.sheet(isPresented: $showLogin) {
				LoginView()
			}
	}
}

enum ContentService {
	static func loadContent() throws {}
}

enum AnalyticsService {
	static func log(_ error: Error) {}
}
