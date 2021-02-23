//
//  SearchDataSourceController.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 10.02.21.
//

import UIKit

final class SearchDataSourceController: NSObject {
    
    typealias DidSelectClosure = (_ artist: ArtistModel) -> Void
    
    private weak var tableView: UITableView?
    private var artists: [ArtistModel] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var didSelectClosure: DidSelectClosure?
    
    func setUp(with tableView: UITableView) {
        
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableView.rowHeight = 45
    }
    
    func updateArtist(withArtists artists: [ArtistModel]) {
        self.artists = artists
    }
}

extension SearchDataSourceController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let artist = self.artists[indexPath.row]
        let cellModel = SearchTableViewCell.Model(imageURL: artist.imageUrl, title: artist.name)
        cell.configure(model: cellModel)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension SearchDataSourceController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectClosure?(self.artists[indexPath.row])
    }
}
