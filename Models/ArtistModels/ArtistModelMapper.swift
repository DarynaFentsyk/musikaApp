//
//  ArtistModelMapper.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 04.02.21.
//

import Foundation

final class ArtistModelMapper {
    
    func mapAPIToUI (apiArtist: APIArtistModel) -> ArtistModel {
        
        let imageUrl = apiArtist.images?.filter {$0.size == "large"} .first?.text
        return ArtistModel(name: apiArtist.name,
                           imageUrl: URL(string: imageUrl ?? "")
        )
    }
}
