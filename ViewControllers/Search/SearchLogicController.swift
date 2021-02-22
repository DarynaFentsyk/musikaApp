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
    func handleSearchTextDidChange(text: String?)
}

final class SearchLogicController: SearchLogicControllerProtocol {
    
    weak var view: SearchViewControllerProtocol?
    private var timer: Timer?
    
    struct Dependency {
        let musicManager: MusikManagerProtocol
    }
    
    private let dependency: Dependency
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    func getArtists(name: String) {
        
        self.dependency.musicManager.getArtist(artistName: name) { [weak self] result in
            
            switch result {
            case .success(let artists):
                self?.view?.showArtists(artists: artists)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func handleSearchTextDidChange(text: String?) {
        
        self.timer?.invalidate()
        
        if let text = text, text.count >= 3 {
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                self?.getArtists(name: text)
            }
        } else {
            self.resetArtistList()
        }
    }
    
    private func resetArtistList() {
        self.view?.showEmptyArray(artists: [])
    }
}
