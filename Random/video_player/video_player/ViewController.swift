//
//  ViewController.swift
//  video_player
//
//  Created by Petie Positivo on 8/21/23.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playVideo()
    }
    
    private func playVideo() {
        guard let path=Bundle.main.path(forResource: "Alex Jones meme 3", ofType: "mp4") else {
            debugPrint("Alex Jones ain't here")
            return
        }
        
        //fundamental to creating player
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        //where user can interact with the video
        let playerController = AVPlayerViewController()
        
        playerController.player=player
        
        present(playerController, animated: true) {
            player.play()
        }
    }


//    private func findVideo() {
//
//        guard let path = Bundle.main.path(forResource: "Alex Jones meme 3", ofType: "m4v") else {
//
//            debugPrint("Alex Jones meme 3.m4v not found")
//
//            return
//        }
//    }
    
    
}

