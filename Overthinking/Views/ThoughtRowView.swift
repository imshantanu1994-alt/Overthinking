//
//  ThoughtRowView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct ThoughtRowView: View {
    let thought: Thought

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(thought.text).foregroundColor(.white).lineLimit(2)
                HStack {
                    Text(shortState(thought.state)).font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                    Text(
                        RelativeDateTimeFormatter().localizedString(
                            for: thought.createdAt,
                            relativeTo: Date()
                        )
                    ).font(.caption2).foregroundColor(.white.opacity(0.6))
                }
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.white)
        }
        .padding().background(
            RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.03))
        )
    }

    func shortState(_ s: ThoughtState) -> String {
        switch s {
        case .anxious: return "Anxious"
        case .calm: return "Calm"
        case .repetitive: return "Repetitive"
        case .resolved: return "Resolved"
        }
    }
}
