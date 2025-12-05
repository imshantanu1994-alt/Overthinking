//
//  ThoughtListView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct ThoughtListView: View {
    @Environment(GardenViewModel.self) var vm

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Thoughts").font(.headline).foregroundColor(.white)
                Spacer()
                Text("\(vm.thoughts.count)").foregroundColor(
                    .white.opacity(0.7)
                )
            }
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(vm.thoughts) { t in
                        NavigationLink(
                            destination: ThoughtDetailView(thought: t)
                        ) {
                            ThoughtRowView(thought: t)
                        }
                    }
                }
            }
            .frame(maxHeight: 260)
        }
        .padding(.horizontal)
    }
}
