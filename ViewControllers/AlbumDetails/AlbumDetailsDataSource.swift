//
//  AlbumDetailsDataSource.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 15.02.21.
//

import UIKit

final class AlbumDetailsDataSource: NSObject {
    
    private var tableView: UITableView!
    private var album: AlbumDetailsModel
    
    required init(tableView: UITableView, album: AlbumDetailsModel) {
        // ?????
        self.album = album

        super .init()
        
        self.tableView = tableView
        self.tableView.register((UINib(nibName: "TracksTableViewCell" , bundle: nil)), forCellReuseIdentifier: "TracksTableViewCell")
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100
        
    }
    
    func update(withAlbums albums: AlbumDetailsModel) {
        
        self.album = albums
        self.tableView.reloadData()
    }
}

extension AlbumDetailsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        crash?
        return self.album.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TracksTableViewCell", for: indexPath) as! TracksTableViewCell
        let tracks = self.album.tracks[indexPath.row]
        let model = TracksTableViewCell.Model(index: indexPath.row + 1, title: tracks.name, duration: tracks.duration)
        cell.configure(model: model)
        return cell
    }
}
