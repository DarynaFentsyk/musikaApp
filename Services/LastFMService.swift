//
//  LastFMService.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import Foundation

protocol LastFMServiceProtocol {
    
    func getArtist(artistName: String, completion: @escaping ResultHandler<[APIArtistModel], Error>)
    func getAlbums(artistName: String, completion: @escaping ResultHandler<[APIAlbumModel],Error>)
    func getAlbumDetails(artistName: String, albumName: String, completion: @escaping ResultHandler<APIAlbumDetailsModel,Error>)
}

final class LastFMService {
    
    struct Dependency {
        let networkLayer: NetworkLayerProtocol
    }
    
    struct KeyPath {
        
        static let getArtists = "results.artistmatches.artist"
        static let getAlbums = "topalbums.album"
        static let albumDetails = "album"
    }
    
    private let dependency: Dependency
    
    required init(dependency: Dependency = .init(networkLayer: NetworkLayer())) {
        self.dependency = dependency
    }
}

extension LastFMService: LastFMServiceProtocol {
    
    func getArtist(artistName: String, completion: @escaping ResultHandler<[APIArtistModel], Error>) {
        
        guard let name = artistName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        
        let path = "\(Constants.API.baseURL)/?method=artist.search&artist=\(name)&api_key=\(Constants.API.apiKey)&format=json"
        self.dependency.networkLayer.getObject(path: path, keyPath: KeyPath.getArtists, completion: completion)
    }
    
    func getAlbums(artistName: String, completion: @escaping ResultHandler<[APIAlbumModel],Error>) {
        
        guard let name = artistName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        
        let path = "\(Constants.API.baseURL)/?method=artist.gettopalbums&artist=\(name)&api_key=\(Constants.API.apiKey)&format=json"
        self.dependency.networkLayer.getObject(path: path, keyPath: KeyPath.getAlbums, completion: completion)
    }
    
    func getAlbumDetails(artistName: String, albumName: String, completion: @escaping ResultHandler<APIAlbumDetailsModel,Error>) {
        
        guard let artistName = artistName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        guard let albumName = albumName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return
        }
        
        let path = "\(Constants.API.baseURL)/?method=album.getinfo&api_key=\(Constants.API.apiKey)&artist=\(artistName)&album=\(albumName)&format=json"
        self.dependency.networkLayer.getObject(path: path, keyPath: KeyPath.albumDetails, completion: completion)
    }
}


