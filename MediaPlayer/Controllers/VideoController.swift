//
//  VideoController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//

import Foundation

class VideoController {
    
    static func fetchPosts(completion: @escaping (Result<[Media], VideoError>) -> Void) {
        
        guard let finalURL = URL(string: "https://www.reddit.com/r/bettereveryloop/.json") else {return}
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            guard let data = data else {return completion(.failure(.noData))}
            do {
                let topLevelObject = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                
                var arrayOfMedia: [Media] = []
                for i in thirdLevelObject {
                    if i.data.url?.contains("imgur") == true || i.data.url?.contains("gfycat") == true {
                        let url = i.data.preview.reddit_video_preview?.fallback_url
                        let media = Media(title: i.data.title, url: url ?? "")
                        
                        print(media.title + " URL \(media.url)")
                        if media.title != "" && media.url != "" {
                            arrayOfMedia.append(media)
                        }
                    }
                        else {
                            guard let url = i.data.url else {return}
                            let media = Media(title: i.data.title, url: url)
                            print(media.title + media.url)
                            if media.title != "" && media.url != "" {
                                arrayOfMedia.append(media)
                            }
                            
                        }
                }
                completion(.success(arrayOfMedia))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
}
