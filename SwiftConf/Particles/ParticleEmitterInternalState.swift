//
//  ParticleEmitterInternalState.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CGMath
import CoreGraphics
import Foundation
import SwiftUI

extension ParticleEmitter {
	class InternalState {
		enum EmitterMode: Equatable {
			case disabled
			case threshold(TimeInterval, maximum: Int)
			case targetAmount(Int)
		}
		
		let runMode: RunMode
		let emissionRules: Rules
		let emitterMode: EmitterMode
		
		let deadline: Date
		let completion: () -> Void
		
		var initialEmissionDone = false
		var lastUpdate: Date
		var fps: Int = 0
		var particles: [Particle] = []
		var isFinished = false
		
		init(runMode: RunMode, emissionRules: Rules) {
			self.runMode = runMode
			self.emissionRules = emissionRules
			
			switch runMode {
			case let .infinite(.fixed(targetAmount)):
				self.emitterMode = .targetAmount(targetAmount)
				self.deadline = .distantFuture
				self.completion = {}
			case let .infinite(.variable(_, rate, maximum)):
				self.emitterMode = .threshold(1 / TimeInterval(rate), maximum: maximum)
				self.deadline = .distantFuture
				self.completion = {}
			case let .once(_, completion):
				self.emitterMode = .disabled
				self.deadline = .distantFuture
				self.completion = completion
			case let .timed(timeInterval, .fixed(targetAmount), completion):
				self.emitterMode = .targetAmount(targetAmount)
				self.deadline = Date().addingTimeInterval(timeInterval)
				self.completion = completion
			case let .timed(timeInterval, .variable(_, rate, maximum), completion):
				self.emitterMode = .threshold(1 / TimeInterval(rate), maximum: maximum)
				self.deadline = Date().addingTimeInterval(timeInterval)
				self.completion = completion
			}
			
			self.lastUpdate = Date()
		}
		
		func tick(date: Date, canvasSize: CGSize) {
			guard !isFinished else { return }
			let delta = date.timeIntervalSince(lastUpdate)
			guard delta > 0 else { return }
			fps = Int(1 / delta)
			update(date: date, delta: delta, canvasSize: canvasSize)
			lastUpdate = date
			
			if isFinished {
				DispatchQueue.main.async(execute: completion)
			}
		}
		
		private func update(date: Date, delta: TimeInterval, canvasSize: CGSize) {
			if !initialEmissionDone {
				emitStartingParticles(canvasSize: canvasSize)
				initialEmissionDone = true
			}
			emitParticles(delta, canvasSize: canvasSize)
			for particle in particles {
				updateParticle(particle, date: date, delta: delta, canvasSize: canvasSize)
			}
			removeParticles(on: date)
		}
		
		private func emitStartingParticles(canvasSize: CGSize) {
			(0 ..< runMode.initialParticleAmount).forEach { _ in
				emitParticle(canvasSize: canvasSize)
			}
		}
		
		private func removeParticles(on date: Date) {
			particles = particles.filter {
				$0.expiration > date && $0.scale > 0
			}
			guard particles.isEmpty else { return }
			if deadline < Date() || emitterMode == .disabled {
				isFinished = true
			}
		}
		
		private var aggregationTimer: TimeInterval = 0
		private func emitParticles(_ delta: TimeInterval, canvasSize: CGSize) {
			guard deadline > Date() else { return }
			switch emitterMode {
			case let .threshold(threshold, maximum):
				aggregationTimer += delta
				while particles.count < maximum, aggregationTimer > threshold {
					emitParticle(canvasSize: canvasSize)
					aggregationTimer -= threshold
				}
			case let .targetAmount(amount):
				while particles.count < amount {
					emitParticle(canvasSize: canvasSize)
				}
			case .disabled: break
			}
		}
		
		private func emitParticle(canvasSize: CGSize) {
			let imageIndex = emissionRules.newImageIndex
			let colorIndex = emissionRules.matchImagesAndColors ? imageIndex : emissionRules.newColorIndex
			let speed = emissionRules.newSpeed
			let direction = emissionRules.newDirection
			let velocity = CGVector(dx: speed * cos(CGFloat(direction.radians)),
			                        dy: speed * sin(CGFloat(direction.radians)))
			let particle = Particle(imageIndex: imageIndex,
			                        colorIndex: colorIndex,
			                        emittedAt: lastUpdate,
			                        expiration: lastUpdate.addingTimeInterval(emissionRules.newLifetime),
			                        opacity: emissionRules.opacity.opacity(at: 0),
			                        position: emissionRules.newPosition(with: canvasSize),
			                        velocity: velocity,
			                        rotation: emissionRules.newRotation,
			                        rotationSpeed: emissionRules.newRotationSpeed,
			                        scale: emissionRules.newScale,
			                        scaleSpeed: emissionRules.newScaleSpeed)
			particles.append(particle)
		}
		
		private func updateParticle(_ particle: Particle, date: Date, delta: TimeInterval, canvasSize: CGSize) {
			let movement = CGPoint(x: particle.velocity.dx / canvasSize.width,
			                       y: particle.velocity.dy / canvasSize.height)
			//	swiftlint:disable:next shorthand_operator
			particle.position = particle.position + movement * delta
			if particle.position.y > 1 {
				particle.position.y = 1.01
			}
			particle.rotation += particle.rotationSpeed * delta
			particle.scale += particle.scaleSpeed * delta
			let lifetimeProgress = inverseLerp(start: particle.emittedAt.timeIntervalSinceReferenceDate,
			                                   end: particle.expiration.timeIntervalSinceReferenceDate,
			                                   value: date.timeIntervalSinceReferenceDate).clamped()
			particle.opacity = emissionRules.opacity.opacity(at: lifetimeProgress)
			
			particle.velocity += emissionRules.gravity * delta
		}
		
	}
}
