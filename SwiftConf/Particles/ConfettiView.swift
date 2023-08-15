//
//  ConfettiView.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SwiftUI

struct ConfettiView: View {
	
	var body: some View {
		ParticleEmitter(runMode: runMode, emissionRules: rules, debug: false)
			.ignoresSafeArea()
	}
	
	var runMode: ParticleEmitter.RunMode {
		.once(particles: 350) {}
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [
			Image(systemName: "diamond.fill"),
			Image(systemName: "octagon.fill"),
			Image(systemName: "hexagon.fill"),
			Image(systemName: "pentagon.fill"),
		],
					colors: [.red, .green, .blue, .yellow, .purple],
					matchImagesAndColors: false,
					lifetime: 5,
					lifetimeVariation: 0,
					emissionSource: .area(CGRect(x: 0, y: -0.5, width: 1, height: 0.5)),
					opacity: .constant(opacity: 1),
					gravity: .init(dx: 0, dy: 200),
					speed: 10,
					speedVariation: 20,
					direction: .degrees(90),
					rotation: .zero,
					rotationVariation: .degrees(360),
					rotationSpeed: .degrees(90),
					rotationSpeedVariation: .degrees(90),
					scale: 0.5,
					scaleVariation: 0.25,
					scaleSpeed: 0,
					scaleSpeedVariation: 0)
	}
}
