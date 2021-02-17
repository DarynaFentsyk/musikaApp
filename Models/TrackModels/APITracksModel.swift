//
//  APITracksModel.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 04.02.21.
//

import Foundation

struct APITracksModel: Codable {
    
    let tracks: [APITrackModel]
    
    enum CodingKeys: String, CodingKey {
        
        case tracks = "track"
    }
}
