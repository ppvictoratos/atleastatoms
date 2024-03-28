//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Petie Positivo on 5/11/22.
//

import SwiftUI

@ViewBuilder var yoppa: some View { Text("Hit em w da Draco").foregroundColor(.white) }

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.regularMaterial)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct GridStack<Content: View>: View { //generics - you can provider any kind of content you like, but it must conform to View
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    
    func blueTitle() -> some View {
        modifier(BlueTitle())
    }
}

struct ContentView: View {
    @State private var useAltText = false
    let motto = Text("YOLO")
    let peach = Text("🍑")
    
    var body: some View {
        ZStack {
            Color.indigo
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Pete")
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                
                Text("Hello!")
                    .modifier(Title())
                
                Text("Hello Again.")
                    .titleStyle()
                
                Text("Sup")
                    .modifier(BlueTitle())
                
                Button(useAltText ? "Gray!" : "Mint!") {
                    useAltText.toggle()
                }
                .font(.largeTitle)
                .padding()
                .foregroundColor(useAltText ? .gray : .mint)
                .background(.black)
                .clipShape(Capsule())
                
                CapsuleText(text: "🎉")
                CapsuleText(text: "🤷‍♂️")
                
                motto
                    .foregroundColor(.white)
                peach
                    .blur(radius: 2)
                
                yoppa
                
                GridStack(rows: 4, columns: 4) { row, col in
                    HStack {
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row) C\(col)")
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

