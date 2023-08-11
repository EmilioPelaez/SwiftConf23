//
//  HeaderSlide+Extension.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 11/8/23.
//

import SlideKit
import SwiftUI

extension HeaderSlide {
	public init(_ header: String, fontWeight: Font.Weight = .semibold, @ViewBuilder content: @escaping () -> some View, @ViewBuilder auxiliary: @escaping () -> some View) {
		self.init(header, fontWeight: fontWeight) {
			GeometryReader { proxy in
				HStack(alignment: .top, spacing: 0) {
					VStack(alignment: .leading, spacing: 0) {
						content()
					}
					.frame(width: proxy.size.width * 2 / 3)
					auxiliary()
						.frame(width: proxy.size.width / 3)
				}
			}
		}
	}
	
	public init(_ header: String, fontWeight: Font.Weight = .semibold, @ViewBuilder content: @escaping () -> some View, @ViewBuilder extra: @escaping () -> some View) {
		self.init(header, fontWeight: fontWeight) {
			GeometryReader { proxy in
				HStack(alignment: .top, spacing: 0) {
					VStack(alignment: .leading, spacing: 0) {
						content()
					}
					.frame(width: proxy.size.width / 2)
					extra()
						.frame(width: proxy.size.width / 2)
				}
			}
		}
	}
}
