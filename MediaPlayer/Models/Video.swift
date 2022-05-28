//
//  Video.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//

import Foundation


struct PostTopLevelObject: Codable {
    
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Video
    
}

struct Video: Codable {

    let url: String
    let title: String
    
}
