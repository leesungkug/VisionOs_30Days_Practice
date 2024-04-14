//
//  day05App.swift
//  day05
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI

@main
struct day05App: App {
    @State private var currentStyle: ImmersionStyle = .full

    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        .immersionStyle(selection: $currentStyle, in: .full)
        
    }
}
