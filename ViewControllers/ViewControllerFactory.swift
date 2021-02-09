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
                                                                                                     albumDetailsModelMapper: AlbumDetailsModelMapper(trackModelMapper: TrackModelMapper))))
        
        let dependency = HomeLogicController.Dependency(musicManager: MusikManager(dependency: .init(apiService: <#T##LastFMServiceProtocol#>, dbService: <#T##DataBaseServiceProtocol#>, artistModelMapper: <#T##ArtistModelMapper#>, albumModelMapper: <#T##AlbumModelMapper#>, albumDetailsModelMapper: <#T##AlbumDetailsModelMapper#>))
}
}
