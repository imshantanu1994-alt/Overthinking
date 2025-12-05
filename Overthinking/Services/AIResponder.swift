//
//  AIResponder.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import Foundation

// Mock AI responder - replace with real server call or OpenAI proxy when ready.
class AIResponder {
    // simple heuristics
    static func analyze(_ text: String) async -> ThoughtState {
        let low = text.lowercased()
        if low.contains("always") || low.contains("never")
            || low.contains("catastroph")
        {
            return .anxious
        }
        if low.contains("again") || low.contains("repeat")
            || low.contains("what if")
        {
            return .repetitive
        }
        if low.contains("i will") || low.contains("i'll")
            || low.contains("plan")
        {
            return .resolved
        }
        return .calm
    }

    static func stagedReply(for text: String, stage: Int) async -> String {
        switch stage {
        case 0:
            return
                "I hear you — that feels heavy. Want to name one small thing you can control?"
        case 1:
            return
                "Analogy: Imagine the thought as a weather cloud — sometimes it rains, sometimes it passes."
        case 2:
            return
                "What's one tiny (2-minute) action you could take right now to ease it?"
        case 3:
            return "Will this matter in 5 minutes? 5 weeks? 5 months? 5 years?"
        default:
            return "Tell me more."
        }
    }

    static func generateAnalogy(for text: String) -> String {
        return
            "This thought is like a TV episode — vivid now, but only one episode in a whole season."
    }
}
