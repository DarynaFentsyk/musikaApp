//
//  AlbumDetailsLogicController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 15.02.21.
//

import Foundation

protocol AlbumDetailsLogicControllerProtocol: class {
    
    var view: AlbumDetailsViewControllerProtocol? { get set }
    var album: AlbumDetailsModel {get set}
    func loadAlbumInfo()
    func isFavourite() -> Bool
    func toggleFavourite(completion: @escaping ErrorHandler)
    
}

final class AlbumDetailsLogicController {
    
    struct Dependency {
        let musicManager: MusikManagerProtocol
    }
    
    struct Parameter {
        var album: AlbumDetailsModel
    }
    
    weak var view: AlbumDetailsViewControllerProtocol?
    
    var album: AlbumDetailsModel {
        get {
            return parameter.album
        }
        set {
            parameter.album = newValue
        }
    }
    
    private let dependency: Dependency
    private var parameter: Parameter
    
    
    required init(dependency: Dependency, parameter: Parameter) {
        
        self.dependency = dependency
        self.parameter = parameter
    }
}

extension AlbumDetailsLogicController: AlbumDetailsLogicControllerProtocol {
    func loadAlbumInfo() {
        if let tracks = self.parameter.album.tracks {
            self.view?.showAlbumInfo(tracks: tracks)
        } else {
            self.dependency.musicManager.getAlbumDetails(album: self.parameter.album) { [weak self] result in
                
                guard let self = self else {
                    return
                }
                switch result {
                case .failure(let error):
                    print (error)
                case .success(let album):
                    guard let tracks = album.tracks else {
                        print ("no tracks available")
                        return
                    }
                    self.view?.showAlbumInfo(tracks: tracks)
                    self.album = album
                }
                
            }
            
        }
    }
    
    func isFavourite() -> Bool {
        
        return self.dependency.musicManager.isAlbumFavourite(album: self.album)
    }
    
    func toggleFavourite(completion: @escaping ErrorHandler) {
        
        if self.isFavourite() {
            self.dependency.musicManager.deleteAlbum(album: album, completion: completion)
        } else {
            self.dependency.musicManager.saveAlbum(album: album, completion: completion)
        }
    
    }
    
    
    
}

