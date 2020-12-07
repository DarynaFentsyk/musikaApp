//
//  Tracks.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 02.12.20.
//

import Foundation

struct AlbumInfoResults: Codable {
    let album: AlbumDetails
}

struct AlbumDetails: Codable {
    
    let name: String
    let url: String
    let artist: String
    let images: [Image]
    let track: TracksResults
    let wiki: Wiki?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case artist
        case images = "image"
        case track = "tracks"
        case wiki
    }
}

struct TracksResults: Codable {
    let tracks: [Track]
    
    enum CodingKeys: String, CodingKey {
        case tracks = "track"
    }
}

struct Track: Codable {
    let name: String
}

struct Wiki: Codable {
    let summary: String
}
