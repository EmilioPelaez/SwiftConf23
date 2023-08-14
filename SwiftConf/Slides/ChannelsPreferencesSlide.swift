//
//  ChannelsPreferences.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 14/8/23.
//

import SlideKit
import SwiftUI

struct ChannelsPreferencesSlide: Slide {
	var body: some View {
		HeaderSlide("Communication Channels: Preference Keys") {
		}
		.extend()
	}
}

struct ChannelsPreferencesSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ChannelsPreferencesSlide()
		}
	}
}
