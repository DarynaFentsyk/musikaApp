//
//  HomeDataSourceController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import UIKit


final class HomeCollectionViewDataSource: NSObject {
    
    enum Const {
        static let numberOfColumns: CGFloat = 2
    }
    
    typealias DidSelectClosure = (_ album: AlbumModel) -> Void
    
    private weak var collectionView: UICollectionView!
    private var albums: [AlbumModel] = []
    private var artists: [ArtistModel] = []
    var didSelectClosure: DidSelectClosure?
  
    required init(collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
    }
    
    func update(withAlbums albums: [AlbumModel]) {
        
        self.albums = albums
        self.collectionView.reloadData()
    }
    
    func updateArtist(withArtists artists: [ArtistModel]) {
        self.artists = artists
    }
}

extension HomeCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        let album = self.albums[indexPath.item]
        let cellModel = SearchCollectionViewCell.Model(imageURL: album.imageUrl, title: album.name)
        cell.configure(model: cellModel)
        return cell
    }
}

extension HomeCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectClosure?(self.albums[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let minimumInteritemSpacing = flowLayout?.minimumInteritemSpacing ?? 0
        let cellWidth = collectionView.frame.size.width / Const.numberOfColumns - minimumInteritemSpacing/2
        let labelHeight = cellWidth / 4
        return CGSize(width: cellWidth, height: cellWidth + labelHeight)
    }
}

