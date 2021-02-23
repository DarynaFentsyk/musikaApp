//
//  NetworkLayer.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import Alamofire

typealias ResultHandler<T, Error: Swift.Error> = (Swift.Result<T, Error>) -> Void
typealias ErrorHandler = (_ error: Error?) -> Void

protocol NetworkLayerProtocol {
    
    func getObject<T: Codable>(path: String, keyPath: String?, completion: @escaping ResultHandler<T, Error>)
}

final class NetworkLayer: NetworkLayerProtocol {
    
    func getObject<T: Codable>(path: String, keyPath: String?, completion: @escaping ResultHandler<T, Error>) {
        
        AF.request(path).responseData { (response) in
            
            switch response.result {
            case .success(let data):
                do {
                    
                    let object = try JSONDecoder().decode(T.self, from: data, keyPath: keyPath)
                    completion(.success(object))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
