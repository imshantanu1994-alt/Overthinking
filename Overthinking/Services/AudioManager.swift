//
//  AudioManager.swift
//  Overthinking
//
//  Created by Shantanu Mishra  on 05/12/25.
//

import AVFoundation
import Combine
import Foundation

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    private var player: AVAudioPlayer?
    @Published var isPlaying = false

    func playLoop(named filename: String) {
        guard
            let url = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            print("Audio file not found in bundle: \(filename)")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.play()
            isPlaying = true
        } catch {
            print("Audio error: \(error)")
        }
    }

    func stop() {
        player?.stop()
        isPlaying = false
    }
}
