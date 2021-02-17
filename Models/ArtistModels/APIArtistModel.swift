//
//  Model.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 26.11.20.
//

import Foundation

struct APIArtistModel: Codable {
    
    let name:  String
    let images: [APIImageModel]?
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case images = "image"
    }
}

