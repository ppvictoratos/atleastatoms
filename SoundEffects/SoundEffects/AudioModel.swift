////  AudioModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/29/20.
//

import Foundation
import ComposableArchitecture
import Combine
import AVFoundation
import CoreAudioKit
import CoreAudio //needs AUAudioUnitFactory

//if I have an AudioState, should I have a visualizer state?
//how does this work then?..
//[||||||.......] loading..
//so i use a view store for all of these models to live in and they communicate through those hallways

//my animation should be implicit based upon the meter levels given by the avaudioplayer
//this means that the audio player should exist where?
//maybe in an animatable struct?

//there needs to be an animatable struct somewhere.
    //maybe make a custom audio timeline view
    //that could animate, using chunked

//make an audio struct? holds the audio data, metering levels, audio files

//make an animating shape that has a bool
//  true will show view
//  false will show another view

//  or should it be true will allow one type of animation
//  and false will be another

//the view it is embedded in will get the animate bool
    //sound should be processed on a background thread

public struct AudioState {
    public var session: AVAudioSession = AVAudioSession()
    public var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    public init(
        session: AVAudioSession = AVAudioSession(),
        audioPlayer: AVAudioPlayer = AVAudioPlayer()

    ) {
        self.session = session
        self.audioPlayer = audioPlayer
    }
}

extension AudioState: Equatable { }
//extension AudioState: Codable { } why this no work?

public extension AudioState {
    enum Action {
        case none
        case play
        case pause
        case gain
        case fun
    }
}

//can i have something that throws errors in my reducer? how else can i play this audio? should I use an audio unit?

//im having trouble creating my app with TCA.. where should I put the audioplayer init?

public let audioReducer = Reducer<AudioState, AudioState.Action, AudioEnvironment> { state, action, env in
    switch action {
    case .play:
//        state.audioPlayer.init(contentsOf url: "01.mp3")
        state.audioPlayer.play()
        return .none
    case .pause:
        state.audioPlayer.pause()
        return .none
    case .gain:
        state.audioPlayer.setVolume(0.8, fadeDuration: 1.0)
        return .none
    case .fun:
        return .none
    case .none:
        return .none
    }
}

public struct AudioEnvironment {
    //should have isPlaying bool
    //should have isAnimating bool
    //should have the timing event
    var isPlaying: Bool
    var isAnimating: Bool
    var timer: Timer = Timer()
    
    public init(
        isPlaying: Bool,
        isAnimating: Bool,
        timer: Timer
    ) {
        self.isPlaying = isPlaying
        self.isAnimating = isAnimating
        self.timer = timer
    }

}

public struct AudioTestEnvironment {
    public init() { }
}


func startRecording() {
    var recorder: AVAudioRecorder = AVAudioRecorder()
    let audioFile = getDocumentsDirectory().appendingPathComponent("recording.m4a")
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    //how to put recorder in here? or do I move this into AudioState?
    do {
        recorder = try AVAudioRecorder(url: audioFile, settings: settings)
        recorder.record()
    } catch {
        recorder.stop()
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
