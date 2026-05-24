//
//  CHATGPT.swift
//  MyMusicBoard
//
//  Created by Petie Positivo on 8/29/23.
//

import Foundation
import SwiftUI
import UIKit

struct Song: Identifiable {
    let id = UUID()
    let artist: String
    let title: String
    let album: String
    let albumArt: String
    let spotifyURL: String
}

let songs: [Song] = [
    Song(artist: "Artist 1", title: "Song 1", album: "Album 1", albumArt: "album1", spotifyURL: "spotify:track:track_id_1"),
    Song(artist: "Artist 2", title: "Song 2", album: "Album 2", albumArt: "album2", spotifyURL: "spotify:track:track_id_2"),
    // Add more songs here...
]

struct Content2View: View {
    var body: some View {
        NavigationView {
            List(songs) { song in
                NavigationLink(destination: openSpotifyURL(url: song.spotifyURL)) {
                    SongRow(song: song)
                }
            }
            .navigationBarTitle("My Playlist")
        }
    }
    
    func openSpotifyURL(url: String) -> some View {
        // Open Spotify URL using SafariViewController
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            let safariViewController = UIViewController() // Use a UIViewController
            safariViewController.view.backgroundColor = .white
            safariViewController.view.frame = UIScreen.main.bounds
            
            let webView = UIWebView(frame: safariViewController.view.frame)
            webView.loadRequest(URLRequest(url: url))
            safariViewController.view.addSubview(webView)
            
            return AnyView(safariViewController)
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct SongRow: View {
    let song: Song
    
    var body: some View {
        HStack {
            Image(song.albumArt)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text("\(song.artist): \(song.title)")
                    .font(.headline)
                Text(song.album)
                    .font(.subheadline)
            }
        }
    }
}

@main
struct SpotifyPlaylistApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Update your info.plist to have this
//<key>CFBundleURLTypes</key>
//<array>
//    <dict>
//        <key>CFBundleURLSchemes</key>
//        <array>
//            <string>myappspotify</string>
//        </array>
//    </dict>
//</array>
