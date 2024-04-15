//
//  ContentView.swift
//  day06
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @Binding var model: day6ViewModel
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Hello, world!")
            HStack{
                Toggle("Show Immersive Space", isOn: $showImmersiveSpace)
                    .toggleStyle(.button)
                Button(action: {model.addCube(name: "Cube")}, label: {Text("Create Cube")})
            }
            .padding(.top, 50)

        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

//#Preview(windowStyle: .automatic) {
//    ContentView()
//}
