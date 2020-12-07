//
//  Albums.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 25.11.20.
//


import UIKit
import RealmSwift

class SavedTopAlbumDetails: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var artist: String = ""
    @objc dynamic var images: String = ""
    @objc dynamic var tracks: String = ""
    @objc dynamic var wiki: String?
    
}



