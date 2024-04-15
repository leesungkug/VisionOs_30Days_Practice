//
//  day08ViewModel.swift
//  day08
//
//  Created by sungkug_apple_developer_ac on 4/15/24.
//
import SwiftUI
import RealityKit

@Observable
class day08ViewModel {

    private var contentEntity = Entity()

    func setupContentEntity() -> Entity {
        return contentEntity
    }

    func getTargetEntity(name: String) -> Entity? {
        return contentEntity.children.first { $0.name == name}
    }

    func addCube(name: String, posision: SIMD3<Float>, color: UIColor) -> ModelEntity {
        let entity = ModelEntity(
            mesh: .generateBox(size: 0.5, cornerRadius: 0),
            materials: [SimpleMaterial(color: color, isMetallic: false)],
            collisionShape: .generateBox(size: SIMD3<Float>(repeating: 0.5)),
            mass: 0.0
        )

        entity.name = name
        entity.position = posision
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        entity.components.set(CollisionComponent(shapes: [ShapeResource.generateBox(size: SIMD3<Float>(repeating: 0.5))], isStatic: true))
        entity.components.set(HoverEffectComponent())

        contentEntity.addChild(entity)
        
        return entity
    }

    func playAnimation(entity: Entity) {
        let goUp = FromToByAnimation<Transform>(
            name: "goUp",
            from: .init(scale: .init(repeating: 1), translation: entity.position),
            to: .init(scale: .init(repeating: 1), translation: entity.position + .init(x: 0, y: 0.4, z: 0)),
            duration: 0.2,
            timing: .easeOut,
            bindTarget: .transform
        )

        let pause = FromToByAnimation<Transform>(
            name: "pause",
            from: .init(scale: .init(repeating: 1), translation: entity.position + .init(x: 0, y: 0.4, z: 0)),
            to: .init(scale: .init(repeating: 1), translation: entity.position + .init(x: 0, y: 0.4, z: 0)),
            duration: 0.1,
            bindTarget: .transform
        )

        let goDown = FromToByAnimation<Transform>(
            name: "goDown",
            from: .init(scale: .init(repeating: 1), translation: entity.position + .init(x: 0, y: 0.4, z: 0)),
            to: .init(scale: .init(repeating: 1), translation: entity.position),
            duration: 0.2,
            timing: .easeOut,
            bindTarget: .transform
        )
        let from = Transform(rotation: .init(angle: .pi, axis: [0, 0, 1]), translation: SIMD3<Float>(entity.position.x, entity.position.y, entity.position.z))

        let definition = FromToByAnimation(from: from,
                                               duration: 1,
                                                 timing: .linear,
                                             bindTarget: .transform,
                                             repeatMode: .cumulative)
        if let animate = try? AnimationResource.generate(with: definition) {
            entity.playAnimation(animate)
        }
        
//
//        let goUpAnimation = try! AnimationResource
//            .generate(with: goUp)
//
//        let pauseAnimation = try! AnimationResource
//            .generate(with: pause)
//
//        let goDownAnimation = try! AnimationResource
//            .generate(with: goDown)
//
//        let animation = try! AnimationResource.sequence(with: [goUpAnimation, pauseAnimation, goDownAnimation])
//
//        entity.playAnimation(animation, transitionDuration: 0.5)
    }
}
