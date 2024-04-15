//
//  ImmersiveView.swift
//  day06
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI
import RealityKit

struct ImmersiveView: View {
    @State var model: day6ViewModel
//    @State var model = day6ViewModel()
    @State var cube = Entity()

    var body: some View {
        RealityView { content in
            content.add(model.setupContentEntity())
//            cube = model.addCube(name: "Cube1")
        }
        .gesture(
            DragGesture()
                .targetedToAnyEntity()
                .onChanged { value in
                    value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                }
        )
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    model.changeToRandomColor(entity: value.entity)
                }
        )
    }
}


//#Preview {
//    ImmersiveView()
//        .previewLayout(.sizeThatFits)
//}
