//
//  SongCardView.swift
//  My Music Board
//
//  Created by Petie Positivo on 5/8/23.
//  Guided by ChatGPT.
//

import SwiftUI

struct SongCardView: View {
    let song: Song
    var albumArt: Image?
    let boxSize: CGSize = CGSize(width: 300, height: 80)
    
    var body: some View {
        VStack {
            albumArt?
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(song.title)
                .font(.title)
                .bold()
            
            VStack(spacing: 4) {
                Text(song.artist)
                    .font(.subheadline)
                
                if let features = song.features {
                    Text(features)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: boxSize.width, height: boxSize.height)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            
            //add features, into a flex box
            
            //add a small music player here to play a preview of 3 favorite songs
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

