//
//  GardenViewModel.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import Combine
import CoreLocation
import Foundation
import MapKit

@Observable
class GardenViewModel {
    var thoughts: [Thought] = [
        Thought(text: "Hello", state: ThoughtState.anxious)
    ]
    var gardenMood: String = "Sunny"
    var therapists: [Therapist] = []
    var overthinkTaps: Int = 0
    var feedbacks: [String] = []

    init() {
        loadSampleTherapists()
        updateMood()
    }

    func loadSampleTherapists() {
        therapists = [
            Therapist(
                name: "Dr. Emma Rossi",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.9028,
                    longitude: 12.4964
                ),
                specialty: "CBT & Anxiety"
            ),
            Therapist(
                name: "Dr. Luca Bianchi",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.8902,
                    longitude: 12.4922
                ),
                specialty: "Long-term therapy"
            ),
            Therapist(
                name: "Studio Mindful",
                coordinate: CLLocationCoordinate2D(
                    latitude: 41.9000,
                    longitude: 12.5050
                ),
                specialty: "EMDR & Relaxation"
            ),
        ]
    }

    func addThought(text: String) {
        var t = Thought(text: text, state: .anxious)  // default
        thoughts.insert(t, at: 0)
        updateMood()

        Task {
            let state = await AIResponder.analyze(text)
            // update the most recent matching thought id
            if let idx = thoughts.firstIndex(where: { $0.id == t.id }) {
                thoughts[idx].state = state
                updateMood()
            }
        }
    }

    func resolveThought(_ id: UUID) {
        guard let idx = thoughts.firstIndex(where: { $0.id == id }) else {
            return
        }
        thoughts[idx].state = .resolved
        updateMood()
    }

    func registerOverthinkTap() {
        overthinkTaps += 1
        HapticsManager.shared.softPulse()
        addThought(text: "Overthinking episode #\(overthinkTaps)")
    }

    func necessitySuggestion(for thought: Thought) -> [String] {
        [
            "In 5 minutes: \(likelyToMatter(thought: thought, days: 0.0035))",
            "In 5 weeks: \(likelyToMatter(thought: thought, days: 35))",
            "In 5 months: \(likelyToMatter(thought: thought, days: 150))",
            "In 5 years: \(likelyToMatter(thought: thought, days: 1825))",
        ]
    }

    private func likelyToMatter(thought: Thought, days: Double) -> String {
        switch thought.state {
        case .anxious:
            return days < 1 ? "Probably immediate" : "Less likely long-term"
        case .repetitive: return days < 30 ? "May resurface" : "Could fade"
        case .calm, .resolved: return "Unlikely"
        }
    }

    private func updateMood() {
        let anxious = thoughts.filter { $0.state == .anxious }.count
        let repetitive = thoughts.filter { $0.state == .repetitive }.count
        let resolved = thoughts.filter { $0.state == .resolved }.count
        let calm = thoughts.filter { $0.state == .calm }.count

        if anxious >= max(calm, resolved) && anxious > 0 {
            gardenMood = "Stormy"
        } else if repetitive > anxious {
            gardenMood = "Weedy"
        } else if resolved >= max(anxious, repetitive) && resolved > 0 {
            gardenMood = "Flourishing"
        } else {
            gardenMood = "Sunny"
        }
    }

    func openInMaps(therapist: Therapist) {
        let placemark = MKPlacemark(coordinate: therapist.coordinate)
        let item = MKMapItem(placemark: placemark)
        item.name = therapist.name
        item.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey:
                MKLaunchOptionsDirectionsModeDriving
        ])
    }

    func addFeedback(_ text: String) {
        feedbacks.insert(text, at: 0)
    }
}
