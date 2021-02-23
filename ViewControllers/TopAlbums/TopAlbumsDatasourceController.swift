//
//  TopAlbumsDatasourceController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 11.02.21.
//

import UIKit

final class TopAlbumsDatasourceController: NSObject {
    
    enum Const {
        static let numberOfColumns: CGFloat = 2
    }
    
    typealias DidSelectClosure = (_ album: AlbumModel) -> Void
    
    private let logicController: TopAlbumsLogicControllerProtocol
    private weak var collectionView: UICollectionView!
    private var album: [AlbumModel] = []
    var didSelectClosure: DidSelectClosure?
    
    required init(collectionView: UICollectionView, logicController: TopAlbumsLogicControllerProtocol) {
        self.logicController = logicController
        //        why before super .init()
        super .init()
        
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
    }
    
    func update(withAlbums albums: [AlbumModel]) {
        
        self.album = albums
        self.collectionView.reloadData()
    }
}

extension TopAlbumsDatasourceController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.album.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let album = self.album[indexPath.item]
        let cellModel = SearchCollectionViewCell.Model(imageURL: album.imageUrl, title: album.name)
        cell.configure(model: cellModel)
        return cell
    }
}

extension TopAlbumsDatasourceController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectClosure?(self.album[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
        let minimumInteritemSpacing = flowLayout?.minimumInteritemSpacing ?? 0
        let cellWidth = collectionView.frame.size.width / Const.numberOfColumns - minimumInteritemSpacing / 2
        let labelHeight = cellWidth / 4
        return CGSize(width: cellWidth, height: cellWidth + labelHeight)
    }
}
