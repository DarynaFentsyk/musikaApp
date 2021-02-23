//
//  TopAlbumsCollectionViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 30.11.20.
//
//
// import UIKit
// import Alamofire
// import AlamofireImage
// import RealmSwift
//
//
// var albumNames: [TopAlbumDetails] = []
//
// private let reuseIdentifier = "TopAlbumsCollectionViewCell"
//
// class TopAlbumsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    var nameOfArtist = ""
//    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.collectionView.alwaysBounceVertical = true
//
//        albumNames = []
//        
//        LastFmApiService.shared.getArtistTopAlbums(nameOfArtist: nameOfArtist){
//            (albums) in
//            albumNames = albums
//            self.collectionView.reloadData()
//        }
//    }
//    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return albumNames.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TopAlbumsCollectionViewCell
//        let album = albumNames[indexPath.row].name
//        let albumImage = albumNames[indexPath.row].images
//        cell.topAlbumName.text = album
//        
//        let imageUrl = albumImage.filter({$0.size == "large"}).first?.text ?? ""
//        
//        LastFmApiService.shared.loadImage(imageCache: imageCache, imageURL: imageUrl,defaultImage: #imageLiteral(resourceName: "AlbumPhoto") )
//        {
//            (uiImage) in
//            cell.topAlbumImage.image = uiImage
//        }
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (view.frame.size.width-12)/2
//        return CGSize(width: size, height: size)
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "TopAlbumDetailsTableViewController") as? TopAlbumDetailsTableViewController
//        self.navigationController?.pushViewController(detailedVC!, animated: true)
//        
//        let albumName:String
//        let singerName: String
//        let albumFoto: String 
//        albumName = albumNames[indexPath.row].name
//        singerName = albumNames[indexPath.item].artist.name
//        albumFoto = albumNames[indexPath.row].images.filter({$0.size == "extralarge"}).first?.text ?? ""
//        
//        detailedVC!.albumNameSelected = albumName
//        detailedVC!.selectedSingerName = singerName
//        detailedVC!.selectedAlbumPhoto = albumFoto
//    }
// }
