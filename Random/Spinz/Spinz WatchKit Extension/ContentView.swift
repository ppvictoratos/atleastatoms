//
//  ContentView.swift
//  Spinz WatchKit Extension
//
//  Created by Pete Victoratos on 7/26/21.
//

import SwiftUI

func hueRunner(_ c: TimeInterval, _ d: TimeInterval, _ i: Double) -> Double {
    Double(round(d/i))
}

//struct viewBus: View {
//    var ap: AVAudioPlayer
//    @State var time: Float
//
//    var body: some View {
//    ZStack {
//        Circle()
//            .stroke(style: StrokeStyle(
//                        lineWidth: CGFloat(ap.currentTime),
//                        dash: [CGFloat(ap.currentTime)]))
//            .stroke(style: StrokeStyle(lineWidth: CGFloat(ap.currentTime), dash: [23])) // 3 - 23
//            .foregroundColor(Color(hue: hueRunner(ap.currentTime, ap.duration, Double(hueMax)), saturation: 1.0, brightness: 1.0))
//            .frame(width: 280, height: 280)
//            .animation(.default)
//}

struct ContentView: View {
    @State var scrollAmount = 0.0
    
    @State var animatedValue: CGFloat = 55
    
    var body: some View {
        VStack {
            Text("Scroll: \(scrollAmount)")
                .focusable(true)
                .digitalCrownRotation($scrollAmount, from: 1, through: 100, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
            Circle()
                .stroke(style: StrokeStyle(lineWidth: CGFloat(scrollAmount/10), dash: [CGFloat(scrollAmount/25)]))
                //.foregroundColor(Color(hue: scrollAmount), saturation: 1.0, brightness: 1.0))
                .size(width: CGFloat(scrollAmount), height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/).focusable().digitalCrownRotation($scrollAmount, from: 1, through: 100, by: 1, sensitivity: .low, isContinuous: false, isHapticFeedbackEnabled: true)
                .animation(.default)
                .offset(x: 60, y: 60)
        }
        
}
    
//    func waveAnimation(ap: AVAudioPlayer, mw: CGFloat) {
//        var power: Float = 0.0
//
//        for i in 0..<ap.numberOfChannels {
//            power += ap.averagePower(forChannel: i)
//        }
//
//        let normalize = max(0, power + 55)
//
//        let animated = CGFloat(normalize) * (mw / 55)
//
//        withAnimation(Animation.linear(duration: 0.01)) {
//            self.animatedValue = animated + 55
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
