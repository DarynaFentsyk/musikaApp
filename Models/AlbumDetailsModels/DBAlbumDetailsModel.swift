//
//  Albums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 25.11.20.
//


import UIKit
import RealmSwift

final class DBAlbumDetailsModel: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var artist = ""
    @objc dynamic var images = ""
    var tracks = List<DBTrackModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}




