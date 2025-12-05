//
//  AudioOptionsView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct AudioOptionsView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Text("Calming Audio").font(.title2.bold())
                Button("Play Calm Loop") {
                    AudioManager.shared.playLoop(named: "calm_loop.mp3")
                }
                .buttonStyle(.borderedProminent)
                Button("Play Nature") {
                    AudioManager.shared.playLoop(named: "nature_loop.mp3")
                }
                .buttonStyle(.bordered)
                Button("Stop") { AudioManager.shared.stop() }
                    .buttonStyle(.bordered)
                Spacer()
            }
            .padding()
            .navigationTitle("Audio")
        }
    }
}
