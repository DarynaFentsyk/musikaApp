//
//  Model.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 26.11.20.
//

import Foundation

struct ArtistSearchResultResponce:Codable {
    let results: ArtistsSearchResult
}

struct ArtistsSearchResult: Codable {
    let artistmatches:ArtistSearchResultArtistmatches
}

struct ArtistSearchResultArtistmatches: Codable {
    let artists: [Artist]
    
    enum CodingKeys: String, CodingKey {
        case artists = "artist"
    }
}

struct Artist: Codable {
    let name: String
    let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case name
        case images = "image"
    }
}

struct Image: Codable {
    let text: String
    let size: String
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

