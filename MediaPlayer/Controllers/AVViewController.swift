//
//  ViewController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/30/22.
//

import UIKit
import AVFoundation
import AVKit

class AVViewController: AVPlayerViewController {

    
      override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)

          let url = URL(string: "https://i.imgur.com/bZ9VOc7.mp4")!
          
          playVideo(url: url)
      }
      
      func playVideo(url: URL) {
          let player = AVPlayer(url: url)
          
          let vc = AVPlayerViewController()
          vc.player = player
          
          self.present(vc, animated: true) { vc.player?.play() }
      }
}
