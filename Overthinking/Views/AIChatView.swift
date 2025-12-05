//
//  AIChatView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct AIChatView: View {
    @Environment(GardenViewModel.self) var vm
    @State private var typed = ""
    @State private var messages: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(messages, id: \.self) { m in
                            Text(m).padding().background(
                                Color.gray.opacity(0.12)
                            ).cornerRadius(10)
                        }
                    }
                    .padding()
                }

                HStack {
                    TextField("Write your thought / feedback...", text: $typed)
                        .textFieldStyle(.roundedBorder)
                    Button("Send") { send() }
                }
                .padding()
            }
            .navigationTitle("AI Chat")
        }
    }

    func send() {
        guard !typed.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }
        messages.append("You: \(typed)")
        Task {
            let reply = await AIResponder.stagedReply(for: typed, stage: 0)
            DispatchQueue.main.async { messages.append("AI: \(reply)") }
        }
        typed = ""
    }
}
