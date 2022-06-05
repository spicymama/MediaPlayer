//
//  PostTableViewCell.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//


import UIKit

    class TitleTableViewCell: UITableViewCell {

        @IBOutlet weak var titleLabel: UILabel!
        var video: Media? {
            didSet {
                self.titleLabel.text = video?.title
            }
        }
    }
