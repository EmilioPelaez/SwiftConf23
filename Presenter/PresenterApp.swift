//
//  PresenterApp.swift
//  Presenter
//
//  Created by Emilio Peláez on 13/8/23.
//

import SlideKit
import SwiftUI

@main
struct SwiftConfApp: App {
	
	/// Edit slide configurations in SlideConfiguration.swift
	private static let configuration = SlideConfiguration()
	@StateObject var colorSchemeContainer = ColorSchemeContainer()
	
	/// A presentation content view.
	/// Edit the view here if you'd like to set environments, overlay views or background views.
	var presentationContentView: some View {
		SlideRouterView(slideIndexController: Self.configuration.slideIndexController)
			.slideTheme(Self.configuration.theme)
	}
	
	var body: some Scene {
		WindowGroup {
			macOSPresenterView(
				slideSize: Self.configuration.size,
				slideIndexController: Self.configuration.slideIndexController
			) {
				presentationContentView
			}
			.modifier(ColorSchemeProvider())
			.modifier(ColorSchemeInverter())
			.environmentObject(colorSchemeContainer)
		}
#if os(macOS)
		.setupAsPresenterWindow()
#endif
	}
}
