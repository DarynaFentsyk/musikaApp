//
//  HomeLogicController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import Foundation

protocol HomeLogicControllerProtocol: class {
    var view: HomeViewControllerProtocol? { get set }
    func loadSavedAlbums()
}

final class HomeLogicController {
    
    struct Dependency {
        let musicManager: MusikManagerProtocol
        
    }
    
    private let dependency: Dependency
    
    weak var view: HomeViewControllerProtocol?
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
    
}

extension HomeLogicController: HomeLogicControllerProtocol {
    
    func loadSavedAlbums() {
        self.dependency.musicManager.getSavedAlbums{ [weak self] result in
            
            switch result {
            case.success(let albums):
                self?.view.show
            }
        }
    }
}
