//
//  ViewControllerFactory.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import Foundation


final class ViewControllerFactory {
    
    static func makeHome() -> HomeViewControllerProtocol? {
        
        guard let dataBaseService = DataBaseService(configuration: .defaultConfiguration) else {
            return nil
    }
        
        let dependency = HomeLogicController.Dependency(musicManager: MusikManager(dependency: .init(apiService: LastFMService(),
                                                                                                     dbService: dataBaseService,
                                                                                                     artistModelMapper: ArtistModelMapper(),
                                                                                                     albumModelMapper: AlbumModelMapper(),
                                                                                                     albumDetailsModelMapper: AlbumDetailsModelMapper(trackModelMapper: TrackModelMapper()))))
        
        let logicController = HomeLogicController(dependency: dependency)
        let vc = HomeViewController.make(logicController: logicController)
        
        return vc
    }
    
}
