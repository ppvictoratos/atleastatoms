import Foundation
import AVFoundation
import Cocoa

let engine = AVAudioEngine()
let speedControl = AVAudioUnitVarispeed()
let pitchControl = AVAudioUnitTimePitch()

func play(_ url: URL) throws {
    //load file
    let file = try AVAudioFile(forReading: url)
    
    //create audio player THAT FITS INTO AN ENGINE
    let audioPlayer = AVAudioPlayerNode()
    
    //connect the components into an engine
    engine.attach(audioPlayer)
    engine.attach(pitchControl)
    engine.attach(speedControl)
    
    //arrange the parts of the engine
    engine.connect(audioPlayer, to: speedControl, format: nil)
    engine.connect(speedControl, to: pitchControl, format: nil)
    engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
    
    //prep the player to play its file from the beginning
    audioPlayer.scheduleFile(file, at: nil)
    
    //start engine and player
    try engine.start()
    audioPlayer.play()
}
