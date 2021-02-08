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
    var didSelectClosure: DidSelectClosure?
  
    required init(collectionView: UICollectionView) {
            super.init()
            
            self.collectionView = collectionView
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        }
//    what this functon is updating? Collectionview? When?
    func update(withAlbums albums: [AlbumModel]) {
            self.albums = albums
            self.collectionView.reloadData()
        }
}

extension HomeCollectionViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ _collectionView:UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.albums.count
        
    }
    
    func collectionView(_ _collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath)
        
        let album = self.albums[indexPath.item]
        let cellModel = SearchCollectionViewCell.M
        
        return cell
    }
}

extension HomeCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let cellWidth = collectionView.frame.size.width / Const.numberOfColumns
//
//        return cellWidth
//    }
    

}

