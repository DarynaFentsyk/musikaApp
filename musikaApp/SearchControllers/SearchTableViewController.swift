////
////  SearchTableViewController.swift
////  musikaApp
////
////  Created by Daryna Fentsyk on 27.11.20.
////
//
//import UIKit
//import Alamofire
//import AlamofireImage
//
//private let reuseIdentifier = "SearchCell"
//var filteredArtist: [Artist] = []
//
//class SearchTableViewController: UITableViewController {
//    
//    let search = UISearchController(searchResultsController: nil)
//    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
//    
//    var isSearchBarEmpty: Bool {
//        return search.searchBar.text?.isEmpty ?? true
//    }
//    
//    var isFiltering:Bool {
//        return search.isActive && !isSearchBarEmpty
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.navigationItem.searchController = search
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.title = "Artist"
//        navigationItem.hidesSearchBarWhenScrolling = false
//        
//        search.searchResultsUpdater = self
//        search.obscuresBackgroundDuringPresentation = false
//        search.searchBar.placeholder = "Search for an artist"
//        definesPresentationContext = true
//        
//        tableView.reloadData()
//    }
//    
//    func filterContent(_ searchText:String)  {
//        LastFmApiService.shared.artistSearch(searchText){
//            (searchResults) in
//            filteredArtist = searchResults
//            self.tableView.reloadData()
//        }
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {        if isFiltering {
//        return filteredArtist.count
//    }
//    return filteredArtist.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchTableViewCell
//        
//        let artist: Artist?
//        if isFiltering {
//            artist = filteredArtist[indexPath.row]
//        }else{
//            artist = nil
//        }
//        
//        let artistName = artist?.name ?? ""
//        cell.nameTable.text = artistName
//        let imageUrl = artist?.images.filter({$0.size == "small"}).first?.text ?? ""
//
//        LastFmApiService.shared.loadImage(imageCache: imageCache, imageURL: imageUrl, defaultImage: #imageLiteral(resourceName: "Example")){
//            (uiImage) in
//            cell.artistImage.image = uiImage
//        }
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "TopAlbumsCollectionViewController") as? TopAlbumsCollectionViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
//        vc?.nameOfArtist = filteredArtist[indexPath.row].name
//        vc?.navigationItem.title = "Top Albums"
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return UITableView.automaticDimension
//    }
//}
//
//extension SearchTableViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        filterContent(searchBar.text!)
//        
//    }
//}
