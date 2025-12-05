//
//  HapticsManager.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import CoreHaptics
import UIKit

class HapticsManager {
    static let shared = HapticsManager()
    private var engine: CHHapticEngine?

    private init() {
        prepare()
    }

    func prepare() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptics init error: \(error)")
        }
    }

    func softPulse() {
        let g = UIImpactFeedbackGenerator(style: .soft)
        g.impactOccurred()
    }
}
