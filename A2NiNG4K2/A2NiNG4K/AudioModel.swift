//
//  AudioModel.swift
//  AudioModel
//
//  Created by Pete Victoratos on 8/27/21.
//

import Foundation
import Combine
import ComposableArchitecture
import AVFoundation

public struct AudioState {
    //maybe we can do a foreach here? i dont like repeated code
    public var player1: AVAudioPlayer = AVAudioPlayer()
    public var player2: AVAudioPlayer = AVAudioPlayer()
    public var player3: AVAudioPlayer = AVAudioPlayer()
    public var player4: AVAudioPlayer = AVAudioPlayer()
    
    //then again.. if we need separate audioplayers to layer.. maybe
    //we need to build an audio engine? if i intend on using some TCA for this
    //I need to
    public init(
        player1: AVAudioPlayer = AVAudioPlayer(),
        player2: AVAudioPlayer = AVAudioPlayer(),
        player3: AVAudioPlayer = AVAudioPlayer(),
        player4: AVAudioPlayer = AVAudioPlayer()
    ) {
        self.player1 = player1
        self.player2 = player2
        self.player3 = player3
        self.player4 = player4
    }
}

extension AudioState: Equatable { }

public extension AudioState {
    enum Action {
        case none
        case record
        case play
        case pause
        case volume
        case rewind
        case unwind
    }
}

//public let audioReducer = Reducer<AudioState, AudioState.Action, AudioEnvironment> { state, action, env in
//    switch action {
//case .none:
//    return .none
//case .record:
//    return .none
//case .play:
//    return .none
//case .pause:
//    return .none
//case .volume:
//    return .none
//case .rewind:
//    return .none
//case .unwind:
//    return .none
//}
//}

public struct AudioEnvironment {
    public init() { }
}

public struct AudioTestEnvironment {
    public init() { }
}
