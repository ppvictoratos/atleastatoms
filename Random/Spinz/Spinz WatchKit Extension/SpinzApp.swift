//
//  SpinzApp.swift
//  Spinz WatchKit Extension
//
//  Created by Pete Victoratos on 7/26/21.
//

import SwiftUI

@main
struct SpinzApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
