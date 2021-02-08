////
////  TopAlbumDetailsTableViewController.swift
////  Pods
////
////  Created by Daryna Fentsyk on 01.12.20.
////
//
//import UIKit
//import Alamofire
//import AlamofireImage
//import RealmSwift
//
//var topAlbumDetails: AlbumDetails?
//
//class TopAlbumDetailsTableViewController: UITableViewController {
//    @IBOutlet weak var albumCover: UIImageView!
//    @IBOutlet weak var singerName: UILabel!
//    @IBOutlet weak var selectedAlbumName: UILabel!
//    @IBOutlet weak var selectedAlbumTracks: UILabel!
//    
//    @IBOutlet weak var someLabel: UILabel!
//    
//    @IBOutlet weak var hghghghg: UILabel!
//    @IBAction func didTapSomeButton(_ sender: Any) {
//        
//    }
//    
//    var selectedAlbumPhoto: String = ""
//    var albumNameSelected: String = ""
//    var selectedSingerName: String = ""
//    var tracksToShow: String = ""
//    
//    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
//    
//    lazy var btnSave = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(TopAlbumDetailsTableViewController.saveButtonAction(_:)))
//    lazy var btnDel = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(TopAlbumDetailsTableViewController.saveButtonAction(_:)))
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let imageUrl = selectedAlbumPhoto
//        LastFmApiService.shared.loadImage(imageCache: imageCache, imageURL: imageUrl, defaultImage: #imageLiteral(resourceName: "AlbumCover")) {
//                        (uiImage) in
//                        self.albumCover.image = uiImage
//        }
//        
//        albumCover.image = #imageLiteral(resourceName: "AlbumCover")
//        selectedAlbumName.text = albumNameSelected
//        singerName.text = selectedSingerName
//        selectedAlbumTracks.text = ""
//        self.navigationItem.rightBarButtonItem?.isEnabled = false
//        self.navigationItem.title = "\(albumNameSelected)"
//        
//        
//        LastFmApiService.shared.getAlbumInfo(selectedSingerName: selectedSingerName, albumNameSelected: albumNameSelected)
//        {
//            (albumInfo) in
//            topAlbumDetails = albumInfo
//            
//            let arrayOfStringNames = topAlbumDetails?.track.tracks.map{$0.name} ?? ["No tracks here"]
//            self.tracksToShow = arrayOfStringNames.joined(separator: "\n")
//            self.selectedAlbumTracks.text = self.tracksToShow
//            
//            self.tableView.reloadData()
//        }
//        
//        guard let realm = Realm.safeInit() else {
//            return
//        }
//        
//        if realm.objects(SavedTopAlbumDetails.self)
//            .filter("name = \"\(albumNameSelected)\" AND artist = \"\(selectedSingerName)\"").first != nil {
//            self.navigationItem.rightBarButtonItem = btnDel
//        } else  {
//            self.navigationItem.rightBarButtonItem = btnSave
//        }
//    }
//    
//    @objc func saveButtonAction(_ sender: Any) {
//        guard let realm = Realm.safeInit() else {
//            return
//        }
//                
//        if realm.objects(SavedTopAlbumDetails.self)
//            .filter("name = \"\(albumNameSelected)\" AND artist = \"\(selectedSingerName)\"").first != nil {
//            realmDel(name: albumNameSelected, artist: selectedSingerName)
//            
//            NotificationCenter.default.post(name: NSNotification.Name("Delete"), object: nil)
//            
//            let alert = UIAlertController(title: "Success", message: "Your favourite album was deleted", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
//                alert.dismiss(animated: true, completion: nil)
//            }))
//            self.present(alert, animated: true, completion: nil)
//            self.navigationItem.rightBarButtonItem = btnSave
//        } else  {
//            let savedAlbum = SavedTopAlbumDetails()
//            savedAlbum.artist = selectedSingerName
//            savedAlbum.images = selectedAlbumPhoto
//            savedAlbum.name = albumNameSelected
//            savedAlbum.tracks = tracksToShow
//            
//            realm.safeWrite {
//                realm.add(savedAlbum)
//                
//                let alert = UIAlertController(title: "Congratulations!", message: "Your favourite album was saved", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
//                    alert.dismiss(animated: true, completion: nil)
//                }))
//                self.present(alert, animated: true, completion: nil)
//                self.navigationItem.rightBarButtonItem = btnDel
//                return
//            }
//        }
//        
//        NotificationCenter.default.post(name: NSNotification.Name("Load"), object: nil)
//    }
//    
//    func realmDel(name: String,artist: String) {
//        guard let realm = Realm.safeInit() else {
//            return
//        }
//
//        guard let foundItem = realm.objects(SavedTopAlbumDetails.self).filter("name = \"\(name)\" AND artist = \"\(artist)\"").first
//        else {
//            return
//        }
//        
//        realm.safeWrite {
//            realm.delete(foundItem)
//        }
//    }
//}
