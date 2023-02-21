//
//  FeedContiner.swift
//  iTunesAlbum
//
//  Created by Jaafar Zubaidi  on 2/14/23.
//

import Foundation


struct FeedContiner: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String?
    let id: String?
    let links: [Links]?
    let copyright: String?
    let country: String?
    let icon: String?
    let updated: String?
    let results: [Results]
}
struct Links: Codable{
    let `self`: String?
}
struct Results: Codable, Identifiable {
    let artistName: String?
    let name: String
    let releaseDate: String?
    let kind: String
    let artistId: String?
    let artistUrl: String?
    let contentAdvisoryRating: String?
    let artworkUrl100: String
    let genres: [Genres]?
    let url: String?
    let id: String?
     

}

struct Genres: Codable {
    let genreId: String?
    let name: String?
    let url: String?
}
