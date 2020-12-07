//
//  TopAlbums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 30.11.20.
//

import Foundation

struct TopAlbumSearchResultResponce: Codable {
    let topalbums: TopAlbumSearchResult
}

struct TopAlbumSearchResult: Codable {
    let albums: [TopAlbumDetails]
    
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
}

struct TopAlbumDetails: Codable {
    let name: String
    let url: String
    let artist: TopAlbumArtist
    let images: [Image]
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case artist
        case images = "image"
    }
}

struct TopAlbumArtist: Codable {
    let name: String
    let url: String
}

