//
//  Albums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 25.11.20.
//


import UIKit
import RealmSwift

final class DBAlbumDetailsModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var images: String = ""
    var tracks = List<DBTrackModel>()
    
}




