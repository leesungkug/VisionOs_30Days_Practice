//
//  ContentView.swift
//  day05
//
//  Created by sungkug_apple_developer_ac on 4/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    @State var button_txt = "Show"
    @State var txt_content = "지구(地球, Earth)는 태양으로부터 세 번째 궤도를 도는 행성이다. 현재까지 알려진 생명체가 탄생하고 서식하는 유일한 천체이며 인류가 살아가는 곳이기도 하다."

    var body: some View {
        VStack {
            
            if !immersiveSpaceIsShown{
                
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                Text("우리의 아름다운 지구")

            }
            else{
                Text("우리의 아름다운 지구")
                    .font(.title)
                Text(txt_content)
                    .padding()

            }
            Toggle(button_txt, isOn: $showImmersiveSpace)
                .toggleStyle(.button)
                .padding(.top, 50)
        }
        .padding()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                        self.button_txt = "Back"
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                        self.button_txt = "Show"

                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
