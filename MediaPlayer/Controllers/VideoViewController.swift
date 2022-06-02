//
//  VideoViewController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//
// Gfycat API Credentials:
// Client ID: 2_K3_ZAg
// Client Secret: LMoAbeKHw0rNS_0y4JcZ70FQT799FHYuQ5O0eIVErbhXMAGKmcTkM3Uw6uIXtAyq
//https://gfycat.com/ifr/organicneglectedkinkajou?controls=0&speed=2%27%20frameborder=%270%27%20scrolling=%27no%27%20allowfullscreen%20width=%27640%27%20height=%27453%27%3E%3C/iframe%3E
import UIKit
import YouTubePlayer
import WebKit
import AVKit
import AVFoundation


class VideoViewController: UIViewController, YouTubePlayerDelegate, AVPlayerViewControllerDelegate {
    
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet weak var browserView: WKWebView!
    @IBOutlet weak var avView: UIView!
    let configuration = WKWebViewConfiguration()
    var videoToSend = Video(url: "", title: "")
   // var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in "o" {
            if videoToSend.url.contains("imgur") {
                print("IMGUR \(videoToSend.url)")
                playerView.isHidden = true
                browserView.isHidden = false
                gifView.isHidden = true
                avView.isHidden = true
                loadImgur(url: videoToSend.url)
                continue
            }
            if videoToSend.url.contains("gif") {
                print("GIF \(videoToSend.url)")
                playerView.isHidden = true
                browserView.isHidden = true
                gifView.isHidden = false
                avView.isHidden = true
                loadGif(url: videoToSend.url)
                continue
            }
            if videoToSend.url.contains("gfycat") {
                print("GFYCAT \(videoToSend.url)")
                playerView.isHidden = true
                browserView.isHidden = false
                gifView.isHidden = true
                avView.isHidden = true
                loadGfycat(url: videoToSend.url)
                
                continue
            }
            else {
                print("OTHER \(videoToSend.url)")
                
                // videoToSend.url.contains("youtube") || videoToSend.url.contains("youtu.be")
                gifView.isHidden = true
                browserView.isHidden = true
                playerView.isHidden = false
                avView.isHidden = true
                loadVideo(url: videoToSend.url)
            }
        }
    }
  
   
    
    func loadGif(url: String) {
        let gifImageView = gifView
        guard let url = URL(string: url) else {return}
        guard let gifData = try? Data(contentsOf: url),
              let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        print(images.count)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        gifImageView?.animationImages = images
        if gifImageView?.animationImages?.count != 0 {
            gifImageView?.startAnimating()
            return
        }
        
    }
    
    func loadGfycat(url: String) {
        var skip = false
        var phrase = ""
        for i in url.reversed() {
            if i != "/" && skip == false {
                phrase.insert(i, at: phrase.startIndex)
            }
            if i == "/" {
                skip = true
            }
        }
        guard let url = URL(string: "https://gfycat.com/ifr/" + "\(phrase)" + "?speed=1%27%20allowfullscreen=%20") else {return}
        print(url)
        let myRequest = URLRequest(url: url)
        self.browserView.load(myRequest)
        }
    
    func loadImgur(url: String) {
        /*
        var skip = false
        var phrase = ""
        for i in url.reversed() {
            if i != "/" && skip == false {
                phrase.insert(i, at: phrase.startIndex)
            }
            if i == "/" {
                skip = true
            }
        }

        guard let url = URL(string: "https://i.imgur.com/" + phrase) else {return}
        */
        guard let url = URL(string: url) else {return}
        print(url)
        let myRequest = URLRequest(url: url)
            
            self.browserView.load(myRequest)
    }
    
    func loadVideo(url: String) {
        
        guard let vidURL = URL(string: "\(videoToSend.url)") else {return}
        playerView.delegate = self
        playerView.loadVideoURL(vidURL)
        if playerView.ready == true {
            self.playerView.play()
            self.playerView.clipsToBounds = true
        }
        
    }
}
/*
 func playVideo(url: URL) {
 let player = AVPlayer(url: url)
 let vc = AVPlayerViewController()
 vc.player = player
 
 self.present(vc, animated: true) { vc.player?.play() }
 }
 
 func addPlayerToView(_ view: UIView, url: String) {
     guard let url = URL(string: url) else {return}
         player = AVPlayer(url: url)
         let playerLayer = AVPlayerLayer(player: player)
         playerLayer.videoGravity = .resizeAspectFill
         view.layer.addSublayer(playerLayer)
     player?.play()
     }
 */
