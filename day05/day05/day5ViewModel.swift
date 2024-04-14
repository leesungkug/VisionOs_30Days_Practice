//
//  day5ViewModel.swift
//  day05
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI
import RealityKit

@MainActor class day5ViewModel: ObservableObject {
    private var contentEntity = Entity()
    
    func setupContentEntity() -> Entity {
        return contentEntity
    }
    
    func addCube() {
        guard
            let texture1 = try? TextureResource.load(named: "Number_1"),
            let texture2 = try? TextureResource.load(named: "Number_2"),
            let texture3 = try? TextureResource.load(named: "Number_3"),
            let texture4 = try? TextureResource.load(named: "Number_4"),
            let texture5 = try? TextureResource.load(named: "Number_5"),
            let texture6 = try? TextureResource.load(named: "Number_6")
        else {
            fatalError("Unable to load texture.")
        }
        
        let entity = Entity()

        var material1 = SimpleMaterial()
        var material2 = SimpleMaterial()
        var material3 = SimpleMaterial()
        var material4 = SimpleMaterial()
        var material5 = SimpleMaterial()
        var material6 = SimpleMaterial()

        material1.color = .init(texture: .init(texture1))
        material2.color = .init(texture: .init(texture2))
        material3.color = .init(texture: .init(texture3))
        material4.color = .init(texture: .init(texture4))
        material5.color = .init(texture: .init(texture5))
        material6.color = .init(texture: .init(texture6))

        entity.components.set(ModelComponent(
            mesh: .generateBox(width: 0.5, height: 0.5, depth: 0.5, splitFaces: true),
            materials: [material1, material2, material3, material4, material5, material6])
        )
        
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        entity.components.set(CollisionComponent(shapes: [ShapeResource.generateBox(size: SIMD3<Float>(repeating: 0.5))], isStatic: true))
        entity.components.set(HoverEffectComponent())
        

        entity.position = SIMD3(x: 0, y: 1, z: -2)
        entity.name = "Cube"

        contentEntity.addChild(entity)
    }
}
