//
//  Song.swift
//  My Music Board
//
//  Created by Petie Positivo on 5/8/23.
//  Guided by ChatGPT
//

import Foundation
import SwiftUI

struct Song {
    let title: String
    let artist: String
    let features: String?
    let description: String
    let album: String
    let albumArtURL: URL?
    let releaseYear: String
    
    let spotifyTrackID: String?
    let spotifyPreviewURL: URL?
    
    var albumArt: Image? {
        guard let albumArtURL = albumArtURL else {
            return Image(systemName: "photo") //return the image gotten from spotify api
        }
        
        return Image(systemName: "photo")
    }
}
