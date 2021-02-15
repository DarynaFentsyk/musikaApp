//
//  HomeViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 05.02.21.
//

import UIKit

protocol HomeViewControllerProtocol: UIViewController {
    
    func showAlbums(albums: [AlbumModel])
    func showArtists(artists: [ArtistModel])
}


final class HomeViewController: BaseViewController {

    
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var dataSource: HomeCollectionViewDataSource!
    private var logicController: HomeLogicControllerProtocol!
    
    
    
    lazy var search = UISearchController(searchResultsController: searchViewController)
    lazy var searchViewController = showSearch()
    
    private var isSearchBarEmpty: Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return search.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (self)
        
        self.navigationItem.searchController = search
        
        search.searchResultsUpdater = searchViewController
        search.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        self.title = "test"
        
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.logicController.loadSavedAlbums()
//        
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
    
    private func showSearch() -> SearchViewControllerProtocol! {
        
         let vc = ViewControllerFactory.makeSearch()
        
            vc?.didSelectClosure = { [weak self] artist in
                guard let self = self,
                    let vc = ViewControllerFactory.makeAlbumList(artist: artist) else {
                        return
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            return vc
        }

    
    private func showAlbumDetails(withAlbum album: AlbumDetailsModel) {
        
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func showAlbums(albums: [AlbumModel]) {
        self.dataSource.update(withAlbums: albums)
    }
    
    func showArtists(artists: [ArtistModel]) {
        self.dataSource.updateArtist(withArtists: artists)
    }
}

