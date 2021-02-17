//
//  SearchLogicController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 09.02.21.
//

import Foundation

protocol SearchLogicControllerProtocol: class {
    
    var view: SearchViewControllerProtocol? { get set }
    func getArtists(name: String)
}

final class SearchLogicController: SearchLogicControllerProtocol {
    
    weak var view: SearchViewControllerProtocol?
    
    struct Dependency {
        let musicManager: MusikManagerProtocol
    }
    
    private let dependency: Dependency
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func getArtists(name: String) {
        
        self.dependency.musicManager.getArtist(artistName: name){ [weak self] result in
            
            switch result {
            case .success(let artists):
                self?.view?.showArtists(artists: artists)
            case .failure(let error):
                print (error)
            }
        }
    }
}
