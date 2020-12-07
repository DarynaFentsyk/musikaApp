//
//  FavoritsViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 25.11.20.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

private let reuseIdentifier = "FavoritsCell"

var favoriteAlbums:[SavedTopAlbumDetails] = []
var filteredAlbums: [SavedTopAlbumDetails] = []

class FavoritsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    
    let search = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    var isFiltering:Bool {
        return search.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.searchController = search
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Saved Albums"
        self.collectionView.alwaysBounceVertical = true
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search in saved"
        definesPresentationContext = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadSavedAlbums(notification:)), name: NSNotification.Name(rawValue: "Load"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loadSavedAlbums(notification:)), name: NSNotification.Name(rawValue: "Delete"), object: nil)
        
        guard let realm = Realm.safeInit() else {
            return
        }
        let result = realm.objects(SavedTopAlbumDetails.self)
        favoriteAlbums = Array(result)
    }
    
    func filterContent(_ searchText:String)  {
        filteredAlbums = favoriteAlbums.filter { (album: SavedTopAlbumDetails) -> Bool in
            return album.name.lowercased().contains(searchText.lowercased())
        }
        collectionView.reloadData()
    }
    
    @objc func loadSavedAlbums(notification: NSNotification) {
        guard let realm = Realm.safeInit() else {
            return
        }
        let result = realm.objects(SavedTopAlbumDetails.self)
        favoriteAlbums = Array(result)
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredAlbums.count
        }
        return favoriteAlbums.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavoritsCell
        let album:SavedTopAlbumDetails
        
        if isFiltering {
            album = filteredAlbums[indexPath.row]
        } else {
            album = favoriteAlbums[indexPath.row]
        }
        
        cell.nameOfAlbum.text = album.name
        
        let imageUrl = album.images
        LastFmApiService.shared.loadImage(imageCache: imageCache, imageURL: imageUrl, defaultImage:  #imageLiteral(resourceName: "AlbumPhoto")) {
            (uiImage) in
            cell.pictureOfAlbum.image = uiImage
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (view.frame.size.width-12)/2
        return CGSize(width: size, height: size)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//
//        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
//
//        }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detVC = storyboard?.instantiateViewController(withIdentifier: "DetailsFavouriteTableViewController") as? DetailsFavouriteTableViewController
        
        let album:SavedTopAlbumDetails
        
        if isFiltering {
            album = filteredAlbums[indexPath.row]
        } else {
            album = favoriteAlbums[indexPath.row]
        }
        
        detVC?.tracks = "\(album.tracks)"
        detVC?.album = album.name
        detVC?.artist = album.artist
        detVC?.image = album.images
        
        self.navigationController?.pushViewController(detVC!, animated: true)
    }
}

extension FavoritsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchBar.text!)
    }
}
