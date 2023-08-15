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
			Code(codeRight, colorTheme: codeTheme, fontSize: 26)
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
struct ImageAppApp: App {
	var body: some Scene {
		WindowGroup {
			ImageDisplay(path: "corgi")
				.imageResponder { request in
					let data = ResourceClient.fetch(request.path)
					let uiImage = UIImage(data: data) ?? UIImage()
					return Image(uiImage)
				}
		}
	}
}
"""
		case .assetCatalog:
"""
struct ImageAppApp: App {
	var body: some Scene {
		WindowGroup {
			ImageDisplay(path: "Corgi")
				.imageResponder { request in
					guard let uiImage = UIImage(named: request.path) else {
						return nil
					}
					return Image(uiImage)
				}
				.imageResponder { request in
					let data = ResourceClient.fetch(request.path)
					let uiImage = UIImage(data: data) ?? UIImage()
					return Image(uiImage)
				}
		}
	}
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
"""
Obviously there's no rule that our closures have to be synchronous
By adding an environment value that contains an async closure, we can create a way to fetch remote resources
I'm going to create a simple one for loading images
Now, my view can execute this task and fetch the image
Because we are using a responder chain, we can add more responders that will try to serve the event first
For example, we can add a responder that will look for the image in the asset catalog
"""
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
					return Image(uiImage)
#elseif canImport(AppKit)
					guard let nsImage = NSImage(named: "") else {
						return nil
					}
					return Image(nsImage: nsImage)
#endif
				}
				.imageResponder { request in
					let data = ResourceClient.fetch(request.path)
#if canImport(UIKit)
					let uiImage = UIImage(data: data) ?? UIImage()
					return Image(uiImage)
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
