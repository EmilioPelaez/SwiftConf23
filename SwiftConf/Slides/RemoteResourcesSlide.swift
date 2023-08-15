//
//  RemoteResourcesSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct RemoteResourcesSlide: Slide {
	@Environment(\.codeTheme) var codeTheme
	
	enum SlidePhasedState: Int, PhasedState {
		case initial, remoteResponder, assetCatalog
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Loading Remote Images") {
			Code(codeLeft, colorTheme: codeTheme, fontSize: 30)
		} extra: {
			Code(codeRight, colorTheme: codeTheme, fontSize: 28)
		}
		.extend()
	}
	
	var codeLeft: String {
		switch phasedStateStore.current {
		case .initial:
"""
struct ImageRequest {
	let path: String
}

struct ImageResponder {
	let perform: (ImageRequest)
	async throws -> Image
	
	func callAsFunction(_ request: ImageRequest)
	async throws -> Image {
		try await perform(request)
	}
}

struct ResourceResponderKey: EnvironmentKey {
	static var defaultValue: ImageResponder =
		.init { _ in fatalError("Unhandled Request") }
}
"""
		case .remoteResponder:
"""


ImageDisplay(path: "corgi")
	.imageResponder { request in
		let data = ResourceClient.fetch(request.path)
		guard let uiImage = UIImage(data: data) else {
			throw RemoteImageError.invalidData
		}
		return Image(uiImage: uiImage)
	}
"""
		case .assetCatalog:
"""


ImageDisplay(path: "corgi")
	.imageResponder { request in
		guard let uiImage = UIImage(named: request.path) else {
			return nil
		}
		return Image(uiImage: uiImage)
	}
	.imageResponder { request in
		let data = ResourceClient.fetch(request.path)
		guard let uiImage = UIImage(data: data) else {
			throw RemoteImageError.invalidData
		}
		return Image(uiImage: uiImage)
	}
"""
		}
	}
	
	var codeRight: String {
		switch phasedStateStore.current {
		case .initial, .remoteResponder, .assetCatalog:
"""
struct ImageDisplay: View {
	@Environment(\\.imageResponder) var imageResponder
	
	let path: String
	@State var image: Image?
	
	var body: some View {
		ZStack {
			Color.gray
			if let image {
				image
			}
		}
		.task {
			do {
				let request = ImageRequest(path: path)
				image = try await imageResponder(request)
			} catch {
				image = Image(systemName: "exclamationmark.triangle")
			}
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
Let's build anothr responder chain

This time we're going use it to fetch remote resources, in this example it will only be images

We're basically going to make a request based network client

We start by defining our request, which in this case is very simple

Then we define the closure and the environment key
In this case our closure will have a return value, and it will be async and will throw

On the right I have a simple example of how it would be used

Our view will read the environment value and use it to execute a request to fetch the image

This view doesn't need to know anything about the client that is executing this request
"""
		case .remoteResponder:
"""
I hid a lot of boilerplate code in this example, but hopefully is enough to get an idea

Our responder receives a request
It fetches the data from the network
And then it tries to build an image with

But what if we wanted to use the same mechanism for some images that are already in our asset catalog?
"""
		case .assetCatalog:
"""
We can add a new responder that will try to load a local image

If that fails it will return nil and the next responder will try to load it from the network

This is the end of the example, but we could take it a step farther
We could add another handler that looks for images downloaded to a cache
This would allow us to keep our network and cache code independent
"""
		}

//"""
//Obviously there's no rule that our closures have to be synchronous
//By adding an environment value that contains an async closure, we can create a way to fetch remote resources
//I'm going to create a simple one for loading images
//Now, my view can execute this task and fetch the image
//Because we are using a responder chain, we can add more responders that will try to serve the event first
//For example, we can add a responder that will look for the image in the asset catalog
//"""
	}
}

struct RemoteResourcesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			RemoteResourcesSlide()
		}
	}
}

struct ImageRequest {
	let path: String
}

struct ImageResponder {
	let perform: (ImageRequest)
	async throws -> Image
	
	func callAsFunction(_ request: ImageRequest)
	async throws -> Image {
		try await perform(request)
	}
}

struct ResourceResponderKey: EnvironmentKey {
	static var defaultValue: ImageResponder =
		.init { _ in fatalError("Unhandled Request") }
}

extension EnvironmentValues {
	var imageResponder: ImageResponder {
		get { self[ResourceResponderKey.self] }
		set { self[ResourceResponderKey.self] = newValue }
	}
}

struct ImageDisplay: View {
	@Environment(\.imageResponder) var imageResponder
	
	let path: String
	@State var image: Image?
	
	var body: some View {
		ZStack {
			Color.gray
			if let image {
				image
			}
		}
		.task {
			do {
				let request = ImageRequest(path: path)
				image = try await imageResponder(request)
			} catch {
				image = Image(systemName: "exclamationmark.triangle")
			}
		}
	}
}

struct ImageResponderModifier: ViewModifier {
	func body(content: Content) -> some View {
		content
	}
}

extension View {
	func imageResponder(_ handler: @escaping (ImageRequest) -> Image?) -> some View {
		modifier(ImageResponderModifier())
	}
}

struct ImageAppApp: App {
	var body: some Scene {
		WindowGroup {
			ImageDisplay(path: "Corgi")
				.imageResponder { request in
#if canImport(UIKit)
					guard let uiImage = UIImage(named: request.path) else {
						return nil
					}
					return Image(uiImage: uiImage)
#elseif canImport(AppKit)
					guard let nsImage = NSImage(named: request.path) else {
						return nil
					}
					return Image(nsImage: nsImage)
#endif
				}
				.imageResponder { request in
					let data = ResourceClient.fetch(request.path)
#if canImport(UIKit)
					let uiImage = UIImage(data: data) ?? UIImage()
					return Image(uiImage: uiImage)
#elseif canImport(AppKit)
					let nsImage = NSImage(data: data) ?? NSImage()
					return Image(nsImage: nsImage)
#endif
				}
		}
	}
}

enum ResourceClient {
	static func fetch(_ path: String) -> Data {
		Data()
	}
}
