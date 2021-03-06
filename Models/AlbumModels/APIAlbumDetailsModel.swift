//
//  TopAlbums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 30.11.20.
//

import Foundation

struct APIAlbumDetailsModel: Codable {
    
    let mbid: String?
    let name: String
    let artist: String
    let images: [APIImageModel]?
    let tracks: APITracksModel?
    
    enum CodingKeys: String, CodingKey {
        
        case mbid
        case name
        case artist
        case images = "image"
        case tracks
    }
}
