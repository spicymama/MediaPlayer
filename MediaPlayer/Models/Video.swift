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
    let data: PostFourth
}

struct PostFourth: Codable {
    let title: String
    let url: String?
    let preview: PostFifth
    //let fallback_url: String
}
struct PostFifth: Codable {
    let reddit_video_preview: PostSixth?
}
struct PostSixth: Codable {
    let fallback_url: String?
}
struct Media {
    let title: String
    let url: String
}
