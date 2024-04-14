//
//  day04App.swift
//  day04
//
//  Created by sungkug_apple_developer_ac on 4/13/24.
//
import SwiftUI
import RealityKit

@main
struct day4View: App {

    @StateObject var model = day4ViewModel()
    @State private var style: ImmersionStyle = .full

    
    var body: some SwiftUI.Scene {
        ImmersiveSpace {
            
            RealityView { content in
                content.add(model.setupContentEntity())
            }
            .task {
                await model.runSession()
            }
        }
        .immersionStyle(selection: $style, in: .full)

    }
}
