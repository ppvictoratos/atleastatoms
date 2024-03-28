//
//  ContentView.swift
//  My Music Board
//
//  Created by Petie Positivo on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isSongCardVisible = false
    @State private var isProfileVisible = false
    @State private var isSpinning = false //state for spinning wheel
    @State private var isLocked = false
    @State private var isFlipped = false //state for settings modal
    @State private var profile: Profile = Profile(
        name: "Johnny Boy",
        genres: ["Rock", "Pop", "Rap"],
        message: "Whaddup I like Cheese",
        isSpinning: false
    )
    
    let songs: [Song] = [
        Song(title: "Sunflower Seeds",
             artist: "Yung Nudy",
             features: "",
             description: "Smooth",
             album: "Sli'merre",
             albumArtURL: URL(string: ""),
             releaseYear: "2018",
             spotifyTrackID: "",
             spotifyPreviewURL: URL(string: "")
            )
    ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack{
                    CircleSpinnerView(isSpinning: isSpinning, isLocked: isLocked)
                        .gesture(
                            DragGesture().onEnded { value in
                                guard !isLocked else { return }
                                let velocity = value.predictedEndLocation.x - value.location.x
                                isSpinning = velocity > 0
                            }
                        )
                        .frame(width: UIScreen.main.bounds.width * 0.9,
                               height: UIScreen.main.bounds.width * 0.9)
                                        
                    Button(action: {
                        isSongCardVisible.toggle()
                    }, label: {
                        Image(systemName: "person.circle")
                            .font(.system(size: 90))
                            .padding(50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    })
                    .padding()
                }
                
                Button(action: {
                    isLocked.toggle()
                }, label: {
                    Image(systemName: isLocked ? "lock.fill" : "lock.open")
                        .font(.system(size: 24))
                        .padding()
                })
                
                Spacer()
                
                VStack {
                    Spacer()
                    BannerView(
                        text: "Current Song Playing Title",
                        color: Color.black
                    )
                        .offset(x: UIScreen.main.bounds.width * 0.2)
            
                    Spacer()
                    
                    BannerView(
                        text: "User Profile Name",
                        color: Color.white
                    )
                        .offset(x: -UIScreen.main.bounds.width * 0.28)
                    
                    Spacer()
                    
                }
            }
                
            if isSongCardVisible {
                SongCardView(song: songs[0])
                    .onTapGesture {
                        isSongCardVisible = false
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        }
    }
}

struct BannerView: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.body)
            .foregroundColor(.white)
            .padding()
            .background(color)
    }
}

struct CircleSpinnerView: View {
    let circleCount = 7
    let circleSize: CGFloat = 45
    let circleSpacing: CGFloat = 45
    let spinnerRadius: CGFloat = 130
    
    @State private var angle: Angle = .zero
    
    var isSpinning: Bool
    var isLocked: Bool
    
    var body: some View {
        ZStack {
            ForEach(0..<circleCount) { index in
                Circle()
                    .frame(width: circleSize, height: circleSize)
                    .foregroundColor(.gray)
                    .offset(y: -spinnerRadius)
                    .rotationEffect(angle + .degrees(Double(index) * (360.0 / Double(circleCount))))
            }
        }
        .frame(width: spinnerRadius * 2, height: spinnerRadius * 2)
        .rotationEffect(isSpinning && !isLocked ? angle : .zero)
        .animation(.spring())
        .gesture(
            RotationGesture().onChanged { angle in
                guard !isLocked else { return }
                self.angle = angle
            }
        )
    }
}

struct ProfileView: View {
    var body: some View {
        VStack{
            Image(systemName: "person.crop.circle")
                .font(.system(size: 120))
                .foregroundColor(.gray)
            
            Text("User Name")
                .font(.headline)
                .padding(.top, 10)
            
            Text("A short message about why I love music")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
