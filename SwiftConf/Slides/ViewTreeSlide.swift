//
//  ViewTreeSlide.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 8/8/23.
//

import SlideKit
import SwiftUI

struct ViewTreeSlide: Slide {
	@Environment(\.codeTheme) var codeTheme
	@Environment(\.invertImages) var invertImages
	
	enum SlidePhasedState: Int, PhasedState {
		case initial, realTree, visualization
	}
	
	@Phase var phasedStateStore
	
	var body: some View {
		HeaderSlide("Understanding the View Tree") {
			Code(code, colorTheme: codeTheme, fontSize: 30).extend(.center)
		} extra: {
			if phasedStateStore.when(.initial) {
				SimpleView()
					.extend(.center)
			}
			if phasedStateStore.when(.realTree) {
				Image("Tree")
					.prepare()
					.extend(.center)
			}
			if phasedStateStore.when(.visualization) {
				if invertImages {
					Image("Hierarchy")
						.prepare()
						.extend(.center)
						.colorInvert()
				} else {
					Image("Hierarchy")
						.prepare()
						.extend(.center)
				}
			}
		}
	}
	
	var code: String {
	"""
	VStack(alignment: .leading, spacing: 8) {
		Text("Emilio Peláez")
			.font(.headline)
			.foregroundStyle(.primary)
		VStack(alignment: .leading, spacing: 4) {
			Text("iOS Developer")
			Text("Modus Create")
		}
		.font(.callout)
		.foregroundStyle(.secondary)
	}
	"""
	}
	
	var script: String {
		switch phasedStateStore.current {
		case .initial:
"""
Let's start by looking at a simple SwiftUI view, everybody should be familiar with this

Those with formal data structure knowledge may recognize this as a tree
"""
		case .realTree:
"""
A tree in computer science is a structure with a root node with as many children as it wants
Each child is also a node with any number of children

We can visualize our view like this
"""
		case .visualization:
"""
I know this doesn't really look like a tree
Some people say it's an upside down tree, or the roots of a tree

With this representation we can see all the views are connected
Some connections are more direct than others
The most direct connection is between a parent and a child
Grandparents and children still have a direct path, even if it has a few stops
Siblings and cousins have less direct connections

We can also see taht the tree has a direction
Parents know who their children are, but children don't know who their parent is

We're going to look at the different ways in which we can send data and messages between views
After all a SwiftUI app is a huge tree of connected views

Note: I'm going to use the terms View Tree and View Hierarchy interchangibly
I think View Tree is a bit more accurate, but Apple refers to it as View Hierarchy
"""
		}
	}
}

struct ViewTreeSlide_Previews: PreviewProvider {
	static var previews: some View {
		SlidePreview {
			ViewTreeSlide()
		}
	}
}

struct SimpleView: View {
	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			Text("Emilio Peláez")
				.font(.headline)
				.foregroundStyle(.primary)
			VStack(alignment: .leading, spacing: 4) {
				Text("iOS Developer since 2008")
				Text("Modus Create")
			}
			.font(.callout)
			.foregroundStyle(.secondary)
		}
		.scaleEffect(.init(width: 3, height: 3))
	}
}
