//
//  SpeechService.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import AVFoundation
import Combine  // ← required for ObservableObject
import Foundation
import Speech

final class SpeechService: NSObject, ObservableObject {
    @Published var transcript: String = ""

    private let speechRecognizer = SFSpeechRecognizer(
        locale: Locale(identifier: "en-US")
    )
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                completion(status == .authorized)
            }
        }
        AVAudioSession.sharedInstance().requestRecordPermission {
            _ in /* ignore here */
        }
    }

    func startRecording() throws {
        transcript = ""
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }

        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(
            .record,
            mode: .measurement,
            options: .duckOthers
        )
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) {
            buffer,
            _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()

        task = speechRecognizer?.recognitionTask(with: request) {
            [weak self] result, error in
            if let r = result {
                DispatchQueue.main.async {
                    self?.transcript = r.bestTranscription.formattedString
                }
            }
            if error != nil {
                self?.stopRecording()
            }
        }
    }

    func stopRecording() {
        audioEngine.stop()
        request?.endAudio()
        task?.cancel()
        task = nil
    }
}
