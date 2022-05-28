//
//  PostTableViewController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//

import UIKit

import UIKit

class PostTableViewController: UITableViewController {

    var videoArr: [Video] = []
    
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
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideoVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? VideoViewController else {return}
            let videoToSend = videoArr[indexPath.row]
            destinationVC.videoToSend = videoToSend
        }
      
    }

}
