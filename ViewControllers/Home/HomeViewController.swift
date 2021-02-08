//
//  HomeViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import UIKit


final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: HomeCollectionViewDataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    private func setupUI() {
        self.dataSource = HomeCollectionViewDataSource(collectionView: self.collectionView)
    }
    
}
