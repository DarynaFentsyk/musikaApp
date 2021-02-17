//
//  APIImageModel.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 03.02.21.
//

import Foundation

struct APIImageModel: Codable {
    
    let text: String
    let size: String
    
    enum CodingKeys: String, CodingKey {
        
        case text = "#text"
        case size
    }
}
