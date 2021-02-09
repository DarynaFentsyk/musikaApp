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
    
    static func make(logicController: HomeLogicControllerProtocol) -> HomeViewControllerProtocol {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        logicController.view = vc
        vc.logicController = logicController
        
        return vc
        
    }
    
    private func setupUI() {
        self.dataSource = HomeCollectionViewDataSource(collectionView: self.collectionView)
        self.dataSource.didSelectClosure = { [weak self] album in
            
            guard let self = self else{
                return
            }
          
        }
        
    }
    
    private func showAlbumDetails(withAlbum album: AlbumDetailsModel) {
        
        
    }
    
}

extension HomeViewController: HomeViewControllerProtocol {
    func showAlbums(albums: [AlbumModel]) {
        self.dataSource.update(withAlbums: albums)
    }
}

