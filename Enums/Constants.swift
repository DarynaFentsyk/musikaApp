//
//  Constants.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import Foundation

struct Constants {
    
    private struct BaseURLComponents {
        
        static let scheme = "http"
        static let host = "ws.audioscrobbler.com"
        static let apiVersion = "2.0"
        
    }
    
    enum API {
        
        static var baseURL: String {
            "\(BaseURLComponents.scheme)://\(BaseURLComponents.host)/\(BaseURLComponents.apiVersion)"
        }
        
        static let apiKey = "4c86d8e684a86bb5171350b4bc0b1dc6"
    }
}
