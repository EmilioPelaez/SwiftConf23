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
					triggerEvent(AuthorizationError())
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
struct LoginModifier: ViewModifier {
	@State var showLogin = false
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard event is AuthorizationError else {
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
Something that happens often is that a user will encounter an error where all we can do is show an alert
In this view we're trying to load some content and when that fails, we present an alert that just tells the user they are not authorized
But what if instead of having this kind of code everywhere in our application, we could collect use our responder chain to report the error
"""
		case .errorModifier:
"""
By using the closure we just created we can send an event up the view hierarchy and setup a responder that will handle it
We'll create a modifier that receives the events and if it's a Localized Error, we will show an alert like this
If we receive anything else, we'll just ignore it
Now we can go back to our view and remove all the code that shows the alert and replace it with a call to our closure
We need to make sure that our error handling modifier is high enough in the view hierarchy to respond to all the events
"""
		case .analytics:
"""
And because the responder chain is so modular, we can easily add new handlers
For example, we could add a handler that will log every error that goes through it to our analytics service
In this case, we're receiving all the errors but we're not consuming any of them
"""
		case .login:
"""
We could also add an earlier responder that will look for AuthorizationErrors
Instead of showing an alert it will show the login view
I want to note that order matters here
If the login modifier is added before the analytics handler, the analytics handler will never receive that error
If we add it afterwards it will be logged and then consumed by the login modifier
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
					triggerEvent(AuthorizationError())
				}
			}
	}
}

struct MyApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
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

struct LoginModifier: ViewModifier {
	@State var showLogin = false
	
	func body(content: Content) -> some View {
		content
			.receiveEvent { event in
				guard event is AuthorizationError else {
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
