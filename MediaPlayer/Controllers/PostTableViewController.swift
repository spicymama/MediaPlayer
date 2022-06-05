//
//  PostTableViewController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//

import UIKit
import AVKit
import AVFoundation

class PostTableViewController: UITableViewController, AVPlayerViewControllerDelegate {

    var videoArr: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    var refresh: UIRefreshControl = UIRefreshControl()
    
    func updateViews() {
        VideoController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let videos):
                    self.videoArr = videos
                    
                case .failure(let error):
                     print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
            self.loadData()
        }
    }
    func loadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}

        cell.video = videoArr[indexPath.row]

        return cell
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as? TitleTableViewCell else {return}
        guard let url = URL(string: "https://v.redd.it/93ht09l6kg291/DASH_480.mp4") else {return}
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.view.frame = CGRect(x: 100, y: 100, width: 200, height: 100)
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            vc.player?.play()
            
        }
    }
*/
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAVView" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? GFYViewController else {return}
            let videoToSend = videoArr[indexPath.row]
            destinationVC.videoToSend = videoToSend
        }
      
    }

}
