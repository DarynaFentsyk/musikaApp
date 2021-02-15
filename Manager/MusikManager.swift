//
//  MusikManager.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import Foundation

protocol MusikManagerProtocol {
    
    func getAlbum(artistName: String, completion: @escaping ResultHandler<[AlbumModel], Error>)
    func getArtist(artistName: String, completion: @escaping ResultHandler<[ArtistModel], Error>)
    func getAlbumDetails(album: AlbumDetailsModel, completion: @escaping ResultHandler<AlbumDetailsModel, Error>)
    func getSavedAlbums(completion: @escaping ResultHandler<[AlbumModel], Error>)
    func saveAlbum(album: AlbumDetailsModel, completion: @escaping ErrorHandler)
    func deleteAlbum(album: AlbumDetailsModel, completion: @escaping ErrorHandler )
    func isAlbumFavourite(album: AlbumDetailsModel) -> Bool
    
}

final class MusikManager {
    
    struct Dependency {
        let apiService: LastFMServiceProtocol
        let dbService: DataBaseServiceProtocol
        let artistModelMapper: ArtistModelMapper
        let albumModelMapper: AlbumModelMapper
        let albumDetailsModelMapper: AlbumDetailsModelMapper
    }
    
    private var dependency: Dependency
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension MusikManager: MusikManagerProtocol {
    
    func getAlbum(artistName: String, completion: @escaping ResultHandler<[AlbumModel], Error>) {
        
        self.dependency.apiService.getAlbums(artistName: artistName) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let apiAlbums):
                
                let albums = apiAlbums.map {self.dependency.albumModelMapper.mapAPIToUI(apiAlbum: $0)}
                completion(.success(albums))
                
            }
        }
    }
    
    func getArtist(artistName: String, completion: @escaping ResultHandler<[ArtistModel], Error>) {
        
        self.dependency.apiService.getArtist(artistName: artistName) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let apiArtist):
                
                let artists = apiArtist.map{self.dependency.artistModelMapper.mapAPIToUI(apiArtist: $0)}
                completion(.success(artists))
            }
        }
    }
    
    func getAlbumDetails(album: AlbumDetailsModel, completion: @escaping ResultHandler<AlbumDetailsModel, Error>){
        
        self.dependency.apiService.getAlbumDetails(artistName: album.artist, albumName: album.name) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let apiAlbumDetails):
                
                let album = self.dependency.albumDetailsModelMapper.mapAPIToUI(apiAlbumDetails: apiAlbumDetails)
                completion(.success(album))
            }
            
        }
    }
    func getSavedAlbums(completion: @escaping ResultHandler<[AlbumModel], Error>) {}
    
    func saveAlbum(album: AlbumDetailsModel, completion: @escaping ErrorHandler) {
        
        let dbAlbum = self.dependency.albumDetailsModelMapper.mapUIToDB(album: album)
        self.dependency.dbService.saveAlbum(dbAlbum: dbAlbum, completion: completion)
    }
    
    func deleteAlbum(album: AlbumDetailsModel, completion: @escaping ErrorHandler ) {
        
        self.dependency.dbService.deleteAlbum(id: album.id, completion: completion)
    }
    
    func isAlbumFavourite(album: AlbumDetailsModel) -> Bool {
        
        return self.dependency.dbService.isAlbumSaved(id: album.id)
    }
}
