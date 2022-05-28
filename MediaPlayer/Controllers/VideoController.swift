//
//  VideoController.swift
//  MediaPlayer
//
//  Created by Gavin Woffinden on 5/28/22.
//

import Foundation

class VideoController {
    
    static func fetchPosts(completion: @escaping (Result<[Video], VideoError>) -> Void) {

        guard let finalURL = URL(string: "https://www.reddit.com/r/gifs/.json") else {return}
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
                var arrayOfVideos: [Video] = []
                for i in thirdLevelObject {
                    let video = Video(url: i.data.url, title: i.data.title)
                    arrayOfVideos.append(video)
                    print(video)
                }
                completion(.success(arrayOfVideos))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
}
