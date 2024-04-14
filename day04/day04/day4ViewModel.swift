//
//  day$ViewModel.swift
//  day04
//
//  Created by sungkug_apple_developer_ac on 4/13/24.
//

import SwiftUI
import RealityKit
import ARKit

@MainActor class day4ViewModel: ObservableObject {

    private let session = ARKitSession()
    private let worldTracking = WorldTrackingProvider()
    private var contentEntity = Entity()

    func setupContentEntity() -> Entity {
        let box = ModelEntity(mesh: .generateBox(width: 1.0, height: 1.0, depth: 1.0))
        let material = SimpleMaterial(color: .cyan, isMetallic: true)
        box.model?.materials = [material]
        contentEntity.addChild(box)
        print("\(contentEntity.position)")
        contentEntity.position = SIMD3<Float>(0.0, 0.0, -2.0)
        return contentEntity
    }

    func runSession() async {

        print("WorldTrackingProvider.isSupported: \(WorldTrackingProvider.isSupported)")
        print("PlaneDetectionProvider.isSupported: \(PlaneDetectionProvider.isSupported)")
        print("SceneReconstructionProvider.isSupported: \(SceneReconstructionProvider.isSupported)")
        print("HandTrackingProvider.isSupported: \(HandTrackingProvider.isSupported)")

        Task {
            let authorizationResult = await session.requestAuthorization(for: [.worldSensing])

            for (authorizationType, authorizationStatus) in authorizationResult {
                print("Authorization status for \(authorizationType): \(authorizationStatus)")
                switch authorizationStatus {
                case .allowed:
                    break
                case .denied:
                    break
                case .notDetermined:
                    break
                @unknown default:
                    break
                }
            }
        }

        Task {
            print("Update")
            try await session.run([worldTracking])
            print("Updated")

            for await update in worldTracking.anchorUpdates {
                switch update.event {
                case .added, .updated:
                    print("Anchor position updated.")
                case .removed:
                    print("Anchor position now unknown.")
                }
            }
        }
    }
}
