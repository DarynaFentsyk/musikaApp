//
//  AlbumDetailsModel.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 03.02.21.
//

import Foundation

struct AlbumDetailsModel {
    
    let id: String
    let name: String
    let artist: String
    let imageURl: URL?
    let tracks: [TrackModel]
}
