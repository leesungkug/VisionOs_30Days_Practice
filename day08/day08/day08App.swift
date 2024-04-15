//
//  day08App.swift
//  day08
//
//  Created by sungkug_apple_developer_ac on 4/15/24.
//

import SwiftUI

@main
struct day08App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
