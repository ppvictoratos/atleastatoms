//
//  EffectsModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI
import Combine
import Foundation
import AVFoundation

public struct EffectState {
    

}
    
struct AudioPlayer {
    var engine: AVAudioEngine!
    var player: AVAudioPlayerNode!
    var mixer: AVAudioMixerNode!

    mutating func setup(url: URL) {
        engine = AVAudioEngine()
        player = AVAudioPlayerNode()
        mixer = AVAudioMixerNode()
        
        try? AVAudioSession.sharedInstance().setCategory(.playback)

        guard let file = try? AVAudioFile(forReading: url) else {
            fatalError("Couldn't read file")
        }
        
        print(file.debugDescription)
        
        //After having opened the file, we can create an audio buffer with the file's length and format…
        guard let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length)) else {
            fatalError("Couldn't create buffer")
        }
        
        try? file.read(into: buffer)
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.drumsBitBrush)
        
        player.scheduleBuffer(buffer, at: nil, options: AVAudioPlayerNodeBufferOptions.loops, completionHandler: nil)        
        engine.attach(distortion)
        engine.connect(player, to: distortion, format: buffer.format)
        engine.connect(distortion, to: engine.mainMixerNode, format: buffer.format)
        
        engine.prepare()
        try? engine.start()
        player.play()
    }
    
}


func playEffects() {
    var player = AudioPlayer()
    player.setup(url: URL(fileURLWithPath: "/Users/panagiotis/Desktop/birdsong/SoundEffects/AudioSamples/Outskirt Stand.mp3"))
}

struct viewbis : View {
    var size: CGFloat
    var size2: CGFloat = 0.3
    
    var body: some View {
        Button(action: {
            playEffects()
        }) {
        
        Circle()
            .scaleEffect(size2)
            .foregroundColor(Color("hotpink"))
        }
    }
}


struct Virewews: PreviewProvider {
    static var previews: some View {
        viewbis(size: 3)
    }
}
