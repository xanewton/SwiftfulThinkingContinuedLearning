//
//  SoundsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-04.
//

import SwiftUI
import AVKit

/*
 Sound links
 1 - tada = https://www.freesoundslibrary.com/tada-sound/
 2 - badum = https://www.freesoundslibrary.com/badum-tss/
 3 - moo = https://www.freesoundslibrary.com/cow-moo-sound/
 */

class SoundManager {
    
    static let instance = SoundManager() // Singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada  // same as [tada = "tada"]
        case badum
        case moo
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}


struct SoundsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Play sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("Play sound 2") {
                SoundManager.instance.playSound(sound: .badum)
            }
            Button("Play sound 3") {
                SoundManager.instance.playSound(sound: .moo)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
