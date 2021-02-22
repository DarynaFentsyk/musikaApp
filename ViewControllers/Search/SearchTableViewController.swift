//
//  SearchViewController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 09.02.21.
//

import UIKit

protocol SearchViewControllerProtocol: UIViewController, UISearchResultsUpdating {
    
    func showArtists(artists: [ArtistModel])
    func showEmptyArray(artists: [ArtistModel])
    var didSelectClosure: ((_ artist: ArtistModel) -> Void)? { get set }
}

final class SearchViewController: UIViewController {
    
    typealias DidSelectClosure = (_ artist: ArtistModel) -> Void
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    private var logicController: SearchLogicControllerProtocol!
    private let dataSource = SearchDataSourceController()
    
    var didSelectClosure: DidSelectClosure? {
        get {
            return self.dataSource.didSelectClosure
        }
        set {
            self.dataSource.didSelectClosure = newValue
        }
    }
    
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
        
        self.setupTableView()
        self.setupDataSource()
    }
    
    private func setupTableView() {
        
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        
        self.view.addSubview(self.tableView)
        self.view.addConstraints([leadingConstraint, topConstraint])
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        self.tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    private func setupDataSource() {
        self.dataSource.setUp(with: self.tableView)
    }
}

extension SearchViewController: SearchViewControllerProtocol {
    
    func showEmptyArray(artists: [ArtistModel]) {
        self.dataSource.resetArtist()
    }
    
    func showArtists(artists: [ArtistModel]) {
        self.dataSource.updateArtist(withArtists: artists)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        var timer: Timer?
        timer?.invalidate()
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text, text != "" else {
            return
        }
        
        if text.count >= 3 {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { timer in
                self.logicController.getArtists(name: text) } }
        else {
            self.logicController.resetArtistList()
        }
    }
}
