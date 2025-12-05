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
        ForEach(gardenVM.thoughts, id: \.id) { thought in
            NavigationStack {
                VStack(spacing: 20) {
                    Text("Thought Garden")
                        .font(.largeTitle)
                        .bold()

                    NavigationLink(
                        "Enter Thought",
                        destination: ThoughtDetailView(thought: thought)
                    )
                    .buttonStyle(.borderedProminent)

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
}

struct MyView: View {
    var body: some View {
        Text("One")
    }
}

struct MySecondView: View {
    var body: some View {
        Text("Two")
    }
}

struct CombinedView: View {
    var body: some View {
        VStack {
            MyView()
            MySecondView()
        }
    }
}

#Preview {
    CombinedView()
}
