//
//  ContentView.swift
//  circles
//
//  I would like an application where users can easily highlight the songs they are listening to, weekly. The hopes is that users can look back on their calendar and "relive" feelings via the music they were listening to and share this with others.
//
//  Created by Peter Victoratos on 8/11/20.
//

import SwiftUI

struct ContentView: View {
    static private var SpotifyClientID = "abbd9a3622114a69899ad91bf06b4eb6"
    static private var redirectURL = "Kiklo://returnAfterLogin"
    
    var body: some View {
        
        //make this into a button that pushes the bottom part of the screen and displays the songs this person likes :)
        VStack {
            Image("shneaky")
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(radius:10)
                .overlay(Circle()
                            .stroke(Color.white, lineWidth: 5))
                .scaleEffect(0.5)
            VStack {
            Text("shneakypete")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
            Text("spotify acct")
                .fontWeight(.light)
                .foregroundColor(.white)
            }
            Spacer()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    //shows users current songs in a modal list
                    Button(action: { }) {
                        Image(systemName: "waveform.path")
                            .accentColor(.white)
                            .scaleEffect(3)
                    }
                    Spacer()
                    //allows user to choose songs from their spotify acct in a list with radio buttons, user navigates through playlists
                    Button(action: { }) {
                        Image(systemName: "waveform.path.badge.plus")
                            .accentColor(.white)
                            .scaleEffect(3)
                    }
                    Spacer()
                }
                Spacer()
                //this redirects user to login to spotify
                //opens a safari page for user to authorize their account
                //the user then is sent back to the app and their account should be connected
                Button(action: {
                }) {
                    Text("Connect Spotify")
                        .accentColor(.green)
                }
                Spacer()
            }
        }
        .frame(width: 375, height: 825, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct keeklo: View {
    static var numCircles = 7
    static var tau = CGFloat(2.0 * 3.14159265358979323846)
    var body: some View {
        GeometryReader { boundingBox in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    GeometryReader { square in
                        ForEach(0 ..< keeklo.numCircles) { i in
                            Circle()
                                .fill(Color.white)
                                .frame(width: boundingBox.size.width * 0.8 / 10.0,
                                       height: boundingBox.size.width * 0.8 / 10.0,
                                       alignment: .center
                        )
                            
                    }
                }
                    .background(Color.red)
                    .frame(width: 0.8 * boundingBox.size.width,
                           height: 0.8 * boundingBox.size.width,
                           alignment: .center
                    )
                Spacer()
        }
            Spacer()
                Button(action: {}) {
                    Text("Press").font(.largeTitle)
                }
                Spacer()
    }
}
        .background(Color.red)
    }
}

func initialPosition(boundingBox g: GeometryProxy) -> CGSize {
    return CGSize(width: 4, height: 4)
}

struct SELogo_Previews: PreviewProvider {
    static var previews: some View {
        keeklo()
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName("Logo")
    }
}
