//
//  SoundPlayer.swift
//  ToDo
//
//  Created by Harsh Goutam on 08/02/22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?


func playSound(sound: String, type: String) {
    
  if let path = Bundle.main.path(forResource: sound, ofType: type) {
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
      audioPlayer?.play()
    } catch {
        
      print("Error: Could not find and play the sound file.")
    }
  }
}
