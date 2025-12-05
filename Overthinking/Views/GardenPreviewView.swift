//
//  GardenPreviewView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct GardenPreviewView: View {
    @Environment(GardenViewModel.self) var vm

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18).fill(backgroundGradient).shadow(
                radius: 6
            )
            HStack {
                VStack(alignment: .leading) {
                    Text("Mind Weather").font(.headline).foregroundColor(
                        .white.opacity(0.9)
                    )
                    Text(vm.gardenMood).font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                }
                Spacer()
                HStack(spacing: 10) {
                    ForEach(vm.thoughts.prefix(4)) { t in
                        PlantIconView(thought: t)
                    }
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }

    var backgroundGradient: LinearGradient {
        switch vm.gardenMood {
        case "Stormy":
            return LinearGradient(
                colors: [Color.gray, Color.blue],
                startPoint: .top,
                endPoint: .bottom
            )
        case "Weedy":
            return LinearGradient(
                colors: [Color.green.opacity(0.6), Color.brown.opacity(0.2)],
                startPoint: .top,
                endPoint: .bottom
            )
        case "Flourishing":
            return LinearGradient(
                colors: [Color.yellow, Color.green],
                startPoint: .top,
                endPoint: .bottom
            )
        default:
            return LinearGradient(
                colors: [Color.purple.opacity(0.6), Color.blue.opacity(0.3)],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}
