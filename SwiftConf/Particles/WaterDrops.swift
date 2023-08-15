//
//  WaterDrops.swift
//  SwiftConf
//
//  Created by Emilio Peláez on 15/8/23.
//

import SwiftUI

struct WaterDrops: View {
	
	var body: some View {
		ParticleEmitter(runMode: runMode, emissionRules: rules, debug: false)
			.ignoresSafeArea()
	}
	
	var runMode: ParticleEmitter.RunMode {
		.infinite(.variable(starting: 15, rate: 50, maximum: 100))
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [Image(systemName: "drop.fill")],
					colors: [.blue],
					matchImagesAndColors: false,
					lifetime: 5,
					lifetimeVariation: 4.5,
					emissionSource: .canvas,
					opacity: .fadeOut(duration: 0.15),
					gravity: .init(dx: 0, dy: 0),
					speed: 100,
					speedVariation: 25,
					direction: .degrees(90),
					rotation: .zero,
					rotationVariation: .zero,
					rotationSpeed: .zero,
					rotationSpeedVariation: .zero,
					scale: 2,
					scaleVariation: 1,
					scaleSpeed: -0.05,
					scaleSpeedVariation: 0)
	}
}
