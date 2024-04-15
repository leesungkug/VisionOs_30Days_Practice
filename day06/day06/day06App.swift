//
//  day06App.swift
//  day06
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI

@main
struct day06App: App {
    @State var model = day6ViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(model: $model)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(model: model)
        }
    }
}
