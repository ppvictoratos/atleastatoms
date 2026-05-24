//
//  OtherUI.swift
//  OtherUI
//
//  Created by Pete Victoratos on 8/27/21.
//

import Foundation
import SwiftUI
import AVFoundation

struct TrackShelf: View {
    var body: some View {
        Shelf()
    }
}

struct TrackCardBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center) {
            configuration.label
            configuration.content
        }.padding()
            .background(randomEarthTone())
            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
            .font(.footnote)
            .offset(x: 0, y: 265.0)
    }
    
    func randomEarthTone() -> Color { return Color("Earth1")}
}

struct Shelf: View {
    var body: some View {
        trackCards()
    }
}

struct trackCards: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(0..<14) { _ in
                    GroupBox(
                        label: Label("Title", systemImage: "music.note").foregroundColor(.white)
                    ) {
                        Text("03:24")
                    }.groupBoxStyle(TrackCardBoxStyle())
                }
            }.padding()
                .frame(width: 210.0, height: 180, alignment: .center)
        }            .edgesIgnoringSafeArea(.all)
    }
}

struct TrackShelf_Previews: PreviewProvider {
    static var previews: some View {
        TrackShelf()
    }
}

//Track Sliders
struct TrackSliders: View {
    var body: some View {
        TrackSlider(times: [0.25, 0.5, 0.75, 1.0])
    }
}

//I want to squash this down, for Each? What's the best way to?
struct TrackSlider: View {
    @State var times: [Float]
    
    var body: some View {
        VStack {
            Slider(value: Binding(get: {times[0]}, set: {
                (newValue) in
                times[0] = newValue
            }))
            Slider(value: Binding(get: {times[1]}, set: {
                (newValue) in
                times[1] = newValue
            }))
            Slider(value: Binding(get: {times[2]}, set: {
                (newValue) in
                times[2] = newValue
            }))
            Slider(value: Binding(get: {times[3]}, set: {
                (newValue) in
                times[3] = newValue
            }))
        }
    }
}

struct TrackSliders_Previews: PreviewProvider {
    static var previews: some View {
        TrackSliders()    }
}

//Basic Sound Controls
struct BasicSoundControls: View {
    var audioPlayer = AVAudioPlayer()
    let metronomeImage = UIImage(systemName: "metronome")?.cgImage
    @State var volume: Float
    
    var body: some View {
        
        VStack {
            Spacer()
            
        //metronome
            Image(decorative: metronomeImage!, scale: 0.7, orientation: .up)
                .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            
        //bpm //bars
        HStack {
            BPMText()
            BarsText()
        }
        .padding(.bottom, 10)
        
        //-4 bars, pause/record/play, +4 bars
        PlaybackControls(audioPlayer: audioPlayer)
            
            //master volume
            Slider(value: Binding(get: {volume}, set: {
                (newValue) in
                volume = newValue
            })).padding()
            
            Spacer()
        }
        .padding(.all, 0.0)
    }
}

//could probably make one view that both of these can use to format text & eventually use it as a button that can read values from the tracks

struct BPMText: View {
    var body: some View {
        VStack {
            Text("88")
            Text("BPM")
        }
    }
}

struct BarsText: View {
    var body: some View {
        VStack {
            Text("16")
            Text("Bars")
        }
    }
}

//Gotta rework this guy to accomidate multiple tracks

struct PlaybackControls: View { //View
    var audioPlayer: AVAudioPlayer
    var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                audioPlayer.currentTime -= TimeInterval(10)
            }) {
                Image(systemName: "gobackward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //Play / Pause audio
                
                //isPlaying stays on even when paused
                audioPlayer.play()
                
            }) {
                Image(systemName:  audioPlayback(isPlaying: isPlaying))
                    .foregroundColor(Color("Earth1")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //fast forward song 15 seconds
                audioPlayer.currentTime += TimeInterval(10)
            }) {
                Image(systemName: "goforward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }
        }
    }
    
    func audioPlayback(isPlaying: Bool) -> String { return isPlaying ? "pause.circle.fill" : "play.circle.fill" }
    
}


struct BasicSoundControls_Previews: PreviewProvider {
    static var previews: some View {
        BasicSoundControls(volume: 0.5)
    }
}

