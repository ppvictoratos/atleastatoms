//
//  SoundEffectsApp.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI
import AVFoundation

@main
struct SoundEffectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct SoundEffectsApp_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/.background(Color.init("MainColor"))
            Rectangle().background( Color.init("MainColor"))
        }

        
    }
}
