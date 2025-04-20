//
//  MusicManager.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 20/04/25.
//

import Foundation
import AVFoundation

class MusicManager {
    static let shared = MusicManager()
    private var audioPlayer: AVAudioPlayer?
    private(set) var isMuted: Bool = false
    
    private init() {}
    
    func playBackgroundMusic() {
        guard !isMuted, let path = Bundle.main.path(forResource: "appMusic", ofType: "mp3") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 0.5
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
    
    func toggleMute() {
        isMuted.toggle()
        if isMuted {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }
    
    func setMute(_ muted: Bool) {
        isMuted = muted
        if muted {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
    }
    
}
