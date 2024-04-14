//
//  ImmersiveView.swift
//  day05
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @StateObject var model = day5ViewModel()
    @State var earth_label = "Earth"

    var tap: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { value in
                
//                print("~~~~~~~Cube Taped! ", value.entity.name)
                switch value.entity.name{
                case "Earth":
                    earth_label = "Earth"
                case "Moon":
                    earth_label = "Moon"
                case "Cube":
                    earth_label = "Cube"
                default:
                    earth_label = "other"
                }
            }
    }
    
    var body: some View {
        RealityView { content, attachments in
            if let scene = try? await Entity(named: "Earth", in: realityKitContentBundle) {
                scene.scale = SIMD3<Float>(x: 5, y: 5, z: 5)
                scene.position = SIMD3<Float>(-2.0, 1.2, -2.0)
                scene.name = "Earth"
                setEntityTagetSet(entity: scene)
                content.add(scene)
                if let attachment = attachments.entity(for: "label") {
                    attachment.position = [0, -0.2, 0]
                    scene.addChild(attachment)
                }
            }
            if let moon = try? await Entity(named: "Moon", in: realityKitContentBundle) {
                moon.scale = SIMD3<Float>(x: 2, y: 2, z: 2)
                moon.position = SIMD3<Float>(-4.0, 1.5, -2.0)
                moon.name = "Moon"
                setEntityTagetSet(entity: moon)
                content.add(moon)
            }
            model.addCube()
            content.add(model.setupContentEntity())
        } attachments: {
                Attachment(id: "label") {
                    Text(earth_label)
                        .font(.system(size: 100))
                        .fontWeight(.black)
                        .foregroundStyle(.white)
                }
        }
        .gesture(tap)
    }
    
    func setEntityTagetSet(entity: Entity){
        entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
        entity.components.set(CollisionComponent(shapes: [ShapeResource.generateBox(size: SIMD3<Float>(repeating: 0.5))], isStatic: true))
        entity.components.set(HoverEffectComponent())
    }
}


#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
