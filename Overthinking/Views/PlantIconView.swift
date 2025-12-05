//
//  PlantIconView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct PlantIconView: View {
    let thought: Thought

    var body: some View {
        VStack {
            Image(systemName: iconName)
                .resizable().aspectRatio(contentMode: .fit).frame(
                    width: 40,
                    height: 40
                ).foregroundColor(color)
            Text(shortLabel).font(.caption2).foregroundColor(.white)
        }
        .padding(6)
        .background(
            Color.black.opacity(0.12),
            in: RoundedRectangle(cornerRadius: 8)
        )
    }

    var shortLabel: String {
        switch thought.state {
        case .anxious: return "Anx."
        case .repetitive: return "Loop"
        case .calm: return "Calm"
        case .resolved: return "Done"
        }
    }

    var iconName: String {
        switch thought.state {
        case .anxious: return "hare.fill"
        case .repetitive: return "tortoise.fill"
        case .calm: return "flower.fill"
        case .resolved: return "leaf.fill"
        }
    }

    var color: Color {
        switch thought.state {
        case .anxious: return .purple
        case .repetitive: return .orange
        case .calm: return .mint
        case .resolved: return .green
        }
    }
}
