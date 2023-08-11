//
//  PhasedStateStore+Extensions.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 11/8/23.
//

import SlideKit

extension PhasedState {
	func isBefore(_ state: Self) -> Bool {
		rawValue < state.rawValue
	}
}

extension PhasedStateStore {
	public func before(_ state: State) -> Bool {
		current.isBefore(state)
	}
	
	public func between(_ start: State, and end: State) -> Bool {
		current.rawValue >= start.rawValue && current.rawValue < end.rawValue
	}
}
