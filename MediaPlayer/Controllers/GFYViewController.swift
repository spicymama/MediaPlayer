//
//  GFYViewController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 6/1/22.
//

import UIKit
import AVKit
import AVFoundation
import YouTubePlayer

class GFYViewController: UIViewController, AVPlayerViewControllerDelegate, YouTubePlayerDelegate {
    var videoToSend = Media(title: "", url: "")
    
    @IBOutlet weak var GFYView: UIView!
    @IBOutlet weak var redditGifView: UIImageView!
    @IBOutlet weak var youtubeView: YouTubePlayerView!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if videoToSend.url.contains("youtube") || videoToSend.url.contains("youtu.be"){
            youtubeView.isHidden = false
            redditGifView.isHidden = true
            GFYView.isHidden = true
            loadVideo(url: videoToSend.url)
            //guard let url = URL(string: videoToSend.url) else {return}
            //youtubeView.loadVideoURL(url)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if videoToSend.url.contains("mp4") {
            youtubeView.isHidden = true
            redditGifView.isHidden = true
            GFYView.isHidden = false
            loadGifAVView(url: videoToSend.url)
        }
        if videoToSend.url.contains("i.redd.it") {
            youtubeView.isHidden = true
            redditGifView.isHidden = false
            GFYView.isHidden = true
            loadRedditGif(url: videoToSend.url)
        }
    }
    func loadGifAVView(url: String) {
        guard let url = URL(string: "\(videoToSend.url)") else {return}
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        GFYView.addSubview(vc.view)
        vc.view.frame = GFYView.bounds
        vc.player = player
        vc.showsPlaybackControls = false
        vc.player?.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            vc.player?.play()
        }
    }
    func loadRedditGif(url: String) {
        let gifImageView = redditGifView
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
    func loadVideo(url: String) {
        guard let vidURL = URL(string: "\(videoToSend.url)") else {return}
        youtubeView.delegate = self
        youtubeView.loadVideoURL(vidURL)
        self.youtubeView.clipsToBounds = true
        self.youtubeView.frame = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 415, height: 500)
        if youtubeView.ready == true {
            self.youtubeView.play()
        }
    }
}
