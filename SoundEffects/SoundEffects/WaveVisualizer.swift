//
//  WaveVisualizer.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 10/10/20.
//

import Foundation
import SwiftUI
import AVFoundation
import CoreAudio

let url = Bundle.main.path(forResource: "JACKBOYS", ofType: "mp3")


struct WaveView: View {
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
    
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    
    @State var loudEnough: Bool = false
    
    @State var animatedValue: CGFloat = 55
    
    @State var time: Float = 0
    
    var body: some View {
        ZStack {
            HStack {

                ZStack{
                    Rectangle()
                        .fill(Color.gray)
                    
                    Circle()
                        .fill(Color.white.opacity(0.05))
                    
                    Circle()
                        .fill(Color.white.opacity(0.08))
                        .frame(width: animatedValue / 2, height: animatedValue / 2)
                }
                .frame(width: animatedValue, height: animatedValue)
            }
            
           
        }.onReceive(timer) { (_) in
            if audioPlayer.isPlaying {
                audioPlayer.updateMeters()
                time = Float(audioPlayer.currentTime / audioPlayer.duration)
                
            }
        }
            }
    
    func waveAnimation() {
        var power: Float = 0.0

        for i in 0..<audioPlayer.numberOfChannels {
            power += audioPlayer.averagePower(forChannel: i)
        }

        let normalize = max(0, power + 55)

        let animated = CGFloat(normalize) * (maxWidth / 55)

        withAnimation(Animation.linear(duration: 0.01)) {
            self.animatedValue = animated + 55
        }
    }
    
    }

struct Wave_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            WaveView(loudEnough: true)
        }
    }
}
