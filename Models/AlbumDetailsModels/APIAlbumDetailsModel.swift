//
//  TopAlbums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 30.11.20.
//

import Foundation

struct APIAlbumDetailsModel: Codable {
    
    let name: String
    let artist: APIArtistModel
    let images: [APIImageModel]
    let tracks: APITracksModel
    
    enum CodingKeys: String, CodingKey {
        case name
        case artist
        case images = "image"
        case tracks
        
    }
}
