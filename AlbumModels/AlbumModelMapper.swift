//
//  AlbumModelMapper.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 03.02.21.
//

import Foundation

final class AlbumModelMapper {
    
    func mapAPIToUI (apiAlbum: APIAlbumModel) -> AlbumModel {
        
        let imageUrl = apiAlbum.images.filter({$0.size == "large"}).first?.text
        return AlbumModel(name: apiAlbum.name,
                               artist: apiAlbum.artist.name,
                               imageUrl: URL(string: imageUrl ?? ""))
        
    }
    
}
