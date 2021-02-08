//
//  DetailsFavouriteTableViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.12.20.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

//
//class DetailsFavouriteTableViewController: UITableViewController {
//
//    @IBOutlet weak var savedAlbumCover: UIImageView!
//    @IBOutlet weak var savedArtistName: UILabel!
//    @IBOutlet weak var savedAlbumName: UILabel!
//    @IBOutlet weak var savedTracks: UILabel!
//
//    var tracks = ""
//    var image = ""
//    var album = ""
//    var artist = ""
//
//    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
//
//    lazy var btnSave = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(TopAlbumDetailsTableViewController.saveButtonAction(_:)))
//    lazy var btnDel = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(TopAlbumDetailsTableViewController.saveButtonAction(_:)))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.navigationItem.title = "\(album)"
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
//        savedArtistName.text = artist
//        savedAlbumName.text = album
//        savedTracks.text = tracks
//
//        let imageUrl = image
//
//        LastFmApiService.shared.loadImage(imageCache: imageCache, imageURL: imageUrl, defaultImage: #imageLiteral(resourceName: "AlbumCover")) {
//            (uiImage) in
//            self.savedAlbumCover.image = uiImage
//        }
//
//        guard let realm = Realm.safeInit() else {
//            return
//        }
//        if realm.objects(SavedTopAlbumDetails.self)
//            .filter("name = \"\(album)\" AND artist = \"\(artist)\"").first != nil {
//            self.navigationItem.rightBarButtonItem = btnDel
//        } else  {
//            self.navigationItem.rightBarButtonItem = btnSave
//        }
//    }
//
//    func realmDel(name: String,artist: String) {
//        guard let realm = Realm.safeInit() else {
//            return
//        }
//        guard let foundItem = realm.objects(SavedTopAlbumDetails.self)
//                .filter("name = \"\(name)\" AND artist = \"\(artist)\"").first
//        else {
//            return
//        }
//        realm.safeWrite {
//            realm.delete(foundItem)
//        }
//    }
//
//    @objc func saveButtonAction(_ sender: Any) {
//
//        let realm = try! Realm()
//        let savedAlbum = SavedTopAlbumDetails()
//        savedAlbum.artist = artist
//        savedAlbum.images = image
//        savedAlbum.name = album
//        savedAlbum.tracks = tracks
//        if realm.objects(SavedTopAlbumDetails.self).filter("name = \"\(album)\" AND artist = \"\(artist)\"").first != nil {
//
//            realmDel(name: album, artist: artist)
//            NotificationCenter.default.post(name: NSNotification.Name("Delete"), object: nil)
//
//            let alert = UIAlertController(title: "Success", message: "Your favourite album was deleted", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
//                alert.dismiss(animated: true, completion: nil)
//            }))
//            self.present(alert, animated: true, completion: nil)
//
//            self.navigationItem.rightBarButtonItem = btnSave
//        } else  {
//            realm.safeWrite {
//                realm.add(savedAlbum)
//
//                let alert = UIAlertController(title: "Congratulations!", message: "Your favourite album was saved", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
//                    alert.dismiss(animated: true, completion: nil)
//                }))
//                self.present(alert, animated: true, completion: nil)
//
//                self.navigationItem.rightBarButtonItem = btnDel
//                return
//            }
//        }
//        NotificationCenter.default.post(name: NSNotification.Name("Load"), object: nil)
//    }
//}
