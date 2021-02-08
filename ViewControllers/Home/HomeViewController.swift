//
//  HomeViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import UIKit

protocol HomeViewControllerProtocol: UIViewController {
    
    func showAlbums(albums: [AlbumModel])
}

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: HomeCollectionViewDataSource!
    private var logicController: HomeLogicControllerProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.logicController.loadSavedAlbums()
        
    }
    
    private func setupUI() {
        self.dataSource = HomeCollectionViewDataSource(collectionView: self.collectionView)
        
    }
    
}

extension HomeLogicController: HomeLogicControllerProtocol {
    
    func showAlbum(albums: [AlbumModel]) {
        self.dataSource.update(withAlbums: albums)
    }
    
}
