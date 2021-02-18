//
//  APIAlbumModel.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 03.02.21.
//

import Foundation

struct APIAlbumModel: Codable {
    
    let mbid: String?
    let name: String
    let artist: APIArtistModel
    let images: [APIImageModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case mbid
        case name
        case artist
        case images = "image"
    }
}
