//
//  ContentView.swift
//  day04
//
//  Created by sungkug_apple_developer_ac on 4/13/24.
//

import SwiftUI
import RealityKit

@main
struct ContentView: App {

    @StateObject var model = day4ViewModel()

    var body: some SwiftUI.Scene {
        ImmersiveSpace {
            RealityView { content in
                content.add(model.setupContentEntity())
            }
            .task {
                await model.runSession()
            }
        }
    }
}

