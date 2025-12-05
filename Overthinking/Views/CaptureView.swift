//
//  CaptureView.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import SwiftUI

struct CaptureView: View {
    @Environment(GardenViewModel.self) var vm
    @ObservedObject var speech: SpeechService
    @Environment(\.dismiss) var dismiss

    @State private var text: String = ""
    @State private var recording: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Type or paste your thought...", text: $text)
                    .textFieldStyle(.roundedBorder)

                HStack(spacing: 12) {
                    Button {
                        toggleRecording()
                    } label: {
                        Label(
                            recording ? "Stop" : "Record",
                            systemImage: recording ? "stop.fill" : "mic.fill"
                        )
                    }.buttonStyle(.borderedProminent)

                    Button {
                        save()
                    } label: {
                        Label("Save", systemImage: "checkmark")
                    }.buttonStyle(.borderedProminent)
                }

                if !speech.transcript.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Transcript").font(.headline)
                        Text(speech.transcript).padding().background(
                            Color.gray.opacity(0.08)
                        ).cornerRadius(8)
                            .onTapGesture { text = speech.transcript }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Capture Thought")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .onDisappear { if recording { stopRecording() } }
        }
    }

    func toggleRecording() {
        recording.toggle()
        if recording {
            speech.requestAuthorization { authorized in
                guard authorized else {
                    recording = false
                    return
                }
                do { try speech.startRecording() } catch {
                    print("Speech start failed: \(error)")
                    recording = false
                }
            }
        } else {
            stopRecording()
        }
    }

    func stopRecording() {
        speech.stopRecording()
        recording = false
    }

    func save() {
        let final =
            text.isEmpty
            ? (speech.transcript.isEmpty ? "Empty thought" : speech.transcript)
            : text
        vm.addThought(text: final)
        dismiss()
    }
}
