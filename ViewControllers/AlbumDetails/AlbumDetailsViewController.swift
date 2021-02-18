//
//  AlbumDetailsViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 15.02.21.
//

import UIKit

protocol AlbumDetailsViewControllerProtocol: UIViewController {
    
    func showTracks(tracks: [TrackModel])
}

final class AlbumDetailsViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var logicController: AlbumDetailsLogicControllerProtocol!
    private var dataSource: AlbumDetailsDataSource!
    private weak var favouriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logicController.loadAlbumInfo()
        self.setupUI()
    
    }
    
    private func setupUI() {
        
        self.dataSource = AlbumDetailsDataSource(tableView: self.tableView)
        self.setUpHeaderView()
        self.setUpFavouriteButton()
    }
    
    private func setUpHeaderView() {
        
        let headerView = AlbumHeaderView.make()
        let headerViewModel = AlbumHeaderView.Model(imageUrl: self.logicController.album.imageUrl,
                                                    artistName: self.logicController.album.artist,
                                                    albumName: self.logicController.album.name
        )
        headerView.configure(model: headerViewModel)
        headerView.frame.size.height = headerView.viewHeight
        self.tableView.tableHeaderView = headerView
    }
    
    private func setUpFavouriteButton() {
        
        let image = UIImage.favIcon(isFav: self.logicController.isFavourite())
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.favouriteButtonTapped))
        self.navigationItem.rightBarButtonItem = button
        self.favouriteButton = button
    }
    
    static func make(logicController: AlbumDetailsLogicControllerProtocol) -> AlbumDetailsViewController {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
        logicController.view = vc
        vc.logicController = logicController
        return vc
    }
    
    @objc private func favouriteButtonTapped() {
        
        self.logicController.toggleFavourite { [weak self] error in
            
            guard let self = self else {
                return
            }
            
            if let error = error {
                print (error)
            }
            self.favouriteButton.image = UIImage.favIcon(isFav: self.logicController.isFavourite())
        }
    }
}

extension AlbumDetailsViewController: AlbumDetailsViewControllerProtocol {
    
    func showTracks(tracks: [TrackModel]) {
        self.dataSource.update(withTracks: tracks)
    }
}
