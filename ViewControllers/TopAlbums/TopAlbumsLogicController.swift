//
//  TopAlbumsLogicController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 11.02.21.
//

import Foundation

protocol TopAlbumsLogicControllerProtocol: class {

    var view: TopAlbumsCollectionViewControllerProtocol? { get set }
    func getAlbum()
    
}

final class TopAlbumsLogicController {
    
    struct Dependency {
        let musicManager: MusikManagerProtocol
        
    }
    struct Parameter {
            let artist: ArtistModel
        }
    
    private let dependency: Dependency
    private let parameter: Parameter
    weak var view: TopAlbumsCollectionViewControllerProtocol?
    
    required init(dependency: Dependency, parameter: Parameter) {
        self.dependency = dependency
        self.parameter = parameter
        
    }
}

extension TopAlbumsLogicController: TopAlbumsLogicControllerProtocol {
    
    func getAlbum() {
        self.dependency.musicManager.getAlbum(artistName: self.parameter.artist.name) { [weak self] (result) in
            switch result {
            
            case .failure(let error):
                print (error)
            case .success(let albums):
                self?.view?.showAlbums(albums: albums)
            
            }
            
        }
    }
    
    
}
