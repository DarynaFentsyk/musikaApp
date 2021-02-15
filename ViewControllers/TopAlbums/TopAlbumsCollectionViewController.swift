//
//  TopAlbumsCollectionViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 11.02.21.
//

import UIKit

protocol TopAlbumsCollectionViewControllerProtocol: UIViewController {
    
    func showAlbums(albums: [AlbumModel])
}

final class TopAlbumsCollectionViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource: TopAlbumsDatasourceController!
    private var logicController: TopAlbumsLogicControllerProtocol!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        self.logicController.getAlbum()
        self.setupUI()
        }
        
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.collectionView.reloadData()
        }
    
    static func make(logicController: TopAlbumsLogicControllerProtocol) -> TopAlbumsCollectionViewControllerProtocol {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopAlbumsCollectionViewController") as! TopAlbumsCollectionViewController
        logicController.view = vc
        vc.logicController = logicController
        return vc
    }
    
    private func setupUI() {
        
        self.dataSource = TopAlbumsDatasourceController(collectionView: self.collectionView, logicController: self.logicController)
        self.dataSource.didSelectClosure = { [weak self] artist in
            
            guard let self = self
//                  let vc = ViewControllerFactory.makeAlbumList(artist: artist)
                  else {
                return
            }

        }
        
    }
        
}

extension TopAlbumsCollectionViewController: TopAlbumsCollectionViewControllerProtocol {
    func showAlbums(albums: [AlbumModel]) {
        self.dataSource.update(withAlbums: albums)
    }
    
    
    
}
