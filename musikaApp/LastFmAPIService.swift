//
//  LastFmAPI.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 06.12.20.
//

import Foundation
import Alamofire
import AlamofireImage

class LastFmApiService: NSObject {
    static let shared = LastFmApiService()
    
    let apiUrl = "http://ws.audioscrobbler.com/2.0/"
    let apiKey = "4c86d8e684a86bb5171350b4bc0b1dc6"
//    let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)

    
    private override init() {
        super.init()
    }
    
    func artistSearch (_ query: String, completion: @escaping ([Artist]) -> Void)
    {
        if query.isEmpty {
            completion([])
            return
        }
        let parameters = [
            "method": "artist.search",
            "artist": query,
            "api_key": apiKey,
            "format": "json"
        ]
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: ArtistSearchResultResponce.self)
        {
            (response) in
            completion(response.value?.results.artistmatches.artists ?? [])
        }
    }
    
    func getArtistTopAlbums(nameOfArtist: String, completion: @escaping ([TopAlbumDetails]) -> Void)
    {
        let parameters = [
            "method": "artist.gettopalbums",
            "artist": nameOfArtist,
            "api_key": apiKey,
            "format": "json"
        ]
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: TopAlbumSearchResultResponce.self)
        {
            (response) in
            completion(response.value?.topalbums.albums.filter({$0.name != "(null)"}) ?? [])
        }
    }
    
    func getAlbumInfo(selectedSingerName: String, albumNameSelected: String, completion: @escaping (AlbumDetails?) -> Void)
    {
        let parameters = [
            "method": "album.getinfo",
            "api_key": apiKey,
            "artist": selectedSingerName,
            "album": albumNameSelected,
            "format": "json"
        ]
        AF.request(apiUrl, parameters: parameters).responseDecodable(of: AlbumInfoResults.self)
        {
            (response) in
            completion(response.value?.album)
        }
    }
    
    func loadImage (imageCache: AutoPurgingImageCache, imageURL: String, defaultImage: UIImage, completion: @escaping (UIImage) -> Void) {
        if(imageURL.isEmpty){
            completion(defaultImage)
            return
                
        }

        if let cachedPic = imageCache.image(withIdentifier: imageURL)
        {
            completion(cachedPic)
            return
        }
        AF.request(imageURL).responseImage { response in
            debugPrint(response)
            debugPrint(response.result)
            
            if case .success(let image) = response.result {
                imageCache.add(image, withIdentifier: imageURL)
                completion(image)
            }
            else
            {
                completion(defaultImage)
            }
        }
    }
    
}
