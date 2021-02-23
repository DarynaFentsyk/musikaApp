//
//  JSONDecoder.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import Foundation

extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String?) throws -> T {
        
        guard let keyPath = keyPath else {
            return try decode(type, from: data)
        }
        
        let topLevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (topLevel as AnyObject).value(forKeyPath: keyPath) {
            
            let nestedJSONData = try JSONSerialization.data(withJSONObject: nestedJson)
            return try decode(type, from: nestedJSONData)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nested json not found for key path \"\(keyPath)\""))
        }
    }
}
