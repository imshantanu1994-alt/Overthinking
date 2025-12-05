//
//  ContentView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(GardenViewModel.self) var gardenVM

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Thought Garden")
                    .font(.largeTitle)
                    .bold()
                ForEach(gardenVM.thoughts, id: \.id) { thought in
                    NavigationLink(
                        "Enter Thought",
                        destination: ThoughtDetailView(thought: thought)
                    )
                    .buttonStyle(.borderedProminent)
                }

                NavigationLink(
                    "Garden View",
                    destination: GardenPreviewView()
                )
                .buttonStyle(.borderedProminent)

                NavigationLink("AI Chat", destination: AIChatView())
                    .buttonStyle(.borderedProminent)

                NavigationLink(
                    "Therapist Map",
                    destination: TherapistsMapView()
                )
                .buttonStyle(.borderedProminent)

                NavigationLink(
                    "Audio Options",
                    destination: AudioOptionsView()
                )
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environment(GardenViewModel())
}
