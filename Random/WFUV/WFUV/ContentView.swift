//
//  ContentView.swift
//  WFUV
//
//  Created by Petie Positivo on 6/26/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var isRecording = false
    @State private var capturedImage: NSImage? = nil
    
    var body: some View {
        ZStack {
            WFUVPlayerView()
            
            if let image = capturedImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        isRecording.toggle()
                        
                    }) {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .foregroundColor(.blue)
                            .clipShape(Circle())
                    }
                    .padding(20)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ShapesAnimationView())
    }
}

struct WFUVPlayerView: NSViewRepresentable {
    func makeNSView(context: Context) -> AVPlayerView {
        let player = AVPlayer(url: URL(string: "https://stream.wfuv.org/wfuv-web")!)
        let playerView = AVPlayerView()
        playerView.player = player
        player.play()
        
        return playerView
    }
    
    func updateNSView(_ nsView: AVPlayerView, context: Context) {
        // No update necessary
    }
}

struct ShapeView: View {
    let shape: String
    let color: Color
    
    @State private var shapeSize: CGFloat = 100
    
    var body: some View {
        ZStack {
            if shape == "circle" {
                Circle()
                    .fill(color)
            } else if shape == "square" {
                Rectangle()
                    .fill(color)
            } else if shape == "triangle" {
                Triangle()
                    .fill(color)
            }
        }
        .frame(width: shapeSize, height: shapeSize)
        .transition(.scale)
        .rotationEffect(.degrees(Double.random(in: 0...360)))
        .position(x: CGFloat.random(in: shapeSize/2...geometry.size.width - shapeSize/2),
                  y: CGFloat.random(in: shapeSize/2...geometry.size.height - shapeSize/2))
        .onAppear {
            shapeSize = CGFloat.random(in: 50...150)
        }
    }
    
    @Environment(\.geometry) var geometry
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.midX
        let minY = rect.minY
        let maxY = rect.maxY
        
        path.move(to: CGPoint(x: midX, y: minY))
        path.addLine(to: CGPoint(x: rect.minX, y: maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: maxY))
        path.addLine(to: CGPoint(x: midX, y: minY))
        
        return path
    }
}

struct ShapesAnimationView: View {
    let shapes = ["circle", "square", "triangle"]
    let colorPalettes: [[Color]] = [
        [Color.red, Color.orange, Color.yellow],
        [Color.green, Color.blue, Color.purple],
        [Color.pink, Color.yellow, Color.blue]
    ]
    
    @State private var currentShapeIndex = 0
    @State private var currentPaletteIndex = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(colorPalettes[currentPaletteIndex][0])
                .opacity(0.8)
            
            ForEach(0..<currentShapeIndex, id: \.self) { index in
                ShapeView(shape: shapes[index], color: colorPalettes[currentPaletteIndex][index])
            }
            
            .onAppear {
                animateShapes()
            }
        }
    }
    
    func animateShapes() {
        withAnimation(Animation.easeInOut(duration: 2)) {
            currentShapeIndex += 1
            
            if currentShapeIndex >= shapes.count {
                currentShapeIndex = 0
                currentPaletteIndex += 1
                
                if currentPaletteIndex >= colorPalettes.count {
                    currentPaletteIndex = 0
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            animateShapes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
