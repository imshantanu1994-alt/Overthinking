//
//  ThoughtDetailView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct ThoughtDetailView: View {
    @Environment(GardenViewModel.self) var vm
    let thought: Thought
    @State private var aiText: String = ""
    @State private var aiStage: Int = 0

    var body: some View {
        VStack(spacing: 12) {
            Text(thought.text).font(.title3).padding()
            HStack {
                Text("State: \(labelFor(thought.state))").font(.caption)
                Spacer()
                Text(
                    RelativeDateTimeFormatter().localizedString(
                        for: thought.createdAt,
                        relativeTo: Date()
                    )
                ).font(.caption2)
            }
            Divider()

            VStack(spacing: 8) {
                Button("Talk with AI (staged)") {
                    Task {
                        aiText = await AIResponder.stagedReply(
                            for: thought.text,
                            stage: aiStage
                        )
                        aiStage = min(aiStage + 1, 3)
                    }
                }.buttonStyle(.borderedProminent)

                if !aiText.isEmpty {
                    Text(aiText).padding().background(Color.white.opacity(0.03))
                        .cornerRadius(10)
                    Button("Analogy & Example") {
                        aiText = AIResponder.generateAnalogy(for: thought.text)
                    }
                }

                Button("Show necessity suggestions") {
                    let s = vm.necessitySuggestion(for: thought)
                    aiText = s.joined(separator: "\n")
                }
            }

            Spacer()
            HStack {
                Button("Resolve") {
                    vm.resolveThought(thought.id)
                }.buttonStyle(.bordered)

                Spacer()

                Button("Share feedback") {
                    vm.addFeedback("Feedback re: \(thought.text)")
                }.buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Thought")
    }

    func labelFor(_ s: ThoughtState) -> String {
        switch s {
        case .anxious: return "Anxious"
        case .calm: return "Calm"
        case .repetitive: return "Repetitive"
        case .resolved: return "Resolved"
        }
    }
}
