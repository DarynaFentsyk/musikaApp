//
//  SearchViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 09.02.21.
//

import UIKit

protocol SearchViewControllerProtocol: UIViewController, UISearchResultsUpdating {
    
    func showArtists(artists: [ArtistModel])
    var didSelectClosure: ((_ artist: ArtistModel) -> Void)? { get set }
}

final class SearchViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var logicController: SearchLogicControllerProtocol!
    private var dataSource: SearchDataSourceController!
    
    
    var didSelectClosure: ((_ artist: ArtistModel) -> Void)?
    
    static func make(logicController: SearchLogicControllerProtocol) -> SearchViewController {
        
        let viewController = SearchViewController()
        viewController.logicController = logicController
        logicController.view = viewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
    }
    
    private func setupUI() {
        setupTableView()
        setupDataSource()
    }
    private func setupTableView() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.tableView)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.view.addConstraints([leadingConstraint, topConstraint])
        
    }
    private func setupDataSource() {
        self.dataSource = SearchDataSourceController(tableView: tableView)
        self.dataSource.didSelectClosure = { [weak self] artist in
            self?.didSelectClosure?(artist)
        }
    }
}


extension SearchViewController: SearchViewControllerProtocol {
    
    func showArtists(artists: [ArtistModel]) {
        self.dataSource.updateArtist(withArtists: artists)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text, text != "" else {
            return
        }
        self.logicController.getArtists(name: text)
        
    }
}
