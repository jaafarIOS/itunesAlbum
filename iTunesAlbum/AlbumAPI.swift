//
//  AlbumAPI.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import Foundation

class AlbumAPI {
    func fetchData(completion: @escaping([Results]) -> Void) {
        guard let url = URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let container = try JSONDecoder().decode(FeedContiner.self, from: data)
                DispatchQueue.main.async {
                    completion(container.feed.results)
                }
            }
            catch {
                print("error: \(error)")
                completion([])
            }
        }.resume()
    }
    
}
