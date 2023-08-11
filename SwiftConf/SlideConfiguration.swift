//
//  SlideConfiguration.swift
//
//  This file is automatically generated by SlideGen
//

import SlideKit
import SwiftUI

struct SlideConfiguration {
	
	/// Edit the slide size.
	let size = SlideSize.standard16_9
	
	///  Add your slides into the trailing closure.
	let slideIndexController = SlideIndexController {
		IntroSlide()
		MotivationSlide()
		ViewTreeSlide()
		DownstreamSlide()
		UpstreamSlide()
		MoreEnvironmentValuesSlide()
		ResponderChainSlide()
		ErrorHandlingSlide()
		RemoteResourcesSlide()
		WrapUpSlide()
		OutroSlide()
	}
	
	let theme = PresentationTheme()
}

struct PresentationTheme: SlideTheme {
	let headerSlideStyle = HeaderStyle()
	let itemStyle = ContentStyle()
}
