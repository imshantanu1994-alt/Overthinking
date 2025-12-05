//
//  Thought.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import Foundation

struct Thought: Identifiable {
    let id: UUID
    var text: String
    var createdAt: Date
    var state: ThoughtState

    init(text: String, state: ThoughtState = .anxious) {
        self.id = UUID()
        self.text = text
        self.createdAt = Date()
        self.state = state
    }
}
