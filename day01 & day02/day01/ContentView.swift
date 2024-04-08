//
//  ContentView.swift
//  day01
//
//  Created by sungkug_apple_developer_ac on 4/8/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State private var textIndex = 0
    @State private var opacity = 0.0

    private var visionImage: [String] = ["Earth", "Jupiter", "Moon"]
    @State private var visionImg: String = "Earth"
    var body: some View {

        
        VStack{
            Model3D(named: visionImg, bundle: realityKitContentBundle){ model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)

            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200, alignment: .center)
            .padding()

            
            Text("\(visionImage[textIndex])")
                .font(.system(size: 40, design: .monospaced))
                .fontWeight(.bold)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2)) {
                        opacity = 1.0
                    }
                }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            switch textIndex{
                case 2 :
                    textIndex = 0
                default:
                    textIndex += 1
            }
            print("\(textIndex)")
            visionImg = visionImage[textIndex]
        }
    }

}

#Preview {
    ContentView()
}
