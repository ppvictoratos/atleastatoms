//
//  A2NiNG4KApp.swift
//  A2NiNG4K
//
//  Created by Pete Victoratos on 8/18/21.
//

import SwiftUI

@main
struct A2NiNG4KApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RecorderView(audioRecorder: AudioRecorder())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
