//
//  HeaderSlide+Extension.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 11/8/23.
//

import SlideKit
import SwiftUI

extension HeaderSlide {
	public init(_ header: LocalizedStringKey, @ViewBuilder content: @escaping () -> some View, @ViewBuilder auxiliary: @escaping () -> some View) {
		self.init(header) {
			GeometryReader { proxy in
				HStack(alignment: .top, spacing: 0) {
					VStack(alignment: .leading, spacing: 0) {
						content()
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					auxiliary()
						.frame(width: proxy.size.width / 3)
				}
			}
		}
	}
	
	public init(_ header: LocalizedStringKey, @ViewBuilder content: @escaping () -> some View, @ViewBuilder extra: @escaping () -> some View) {
		self.init(header) {
			GeometryReader { proxy in
				HStack(alignment: .top, spacing: 0) {
					VStack(alignment: .leading, spacing: 0) {
						content()
					}
					.frame(maxWidth: .infinity, alignment: .leading)
					extra()
						.frame(width: proxy.size.width / 2)
				}
			}
		}
	}
}
