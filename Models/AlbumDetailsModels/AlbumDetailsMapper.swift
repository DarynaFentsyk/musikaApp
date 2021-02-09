//
//  AlbumDetailsMapper.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 04.02.21.
//

import Foundation
import RealmSwift

protocol AlbumDetailsModelMapperProtocol {
    
    func mapAPIToUI(apiAlbumDetails: APIAlbumDetailsModel) -> AlbumDetailsModel
    func mapUIToDB(album: AlbumDetailsModel) -> DBAlbumDetailsModel
    func mapDBToUi(dbAlbumDetails: DBAlbumDetailsModel) -> AlbumDetailsModel
}

final class AlbumDetailsModelMapper {
    
    private let trackModelMapper: TrackModelMapperProtocol
    
    init(trackModelMapper: TrackModelMapperProtocol) {
        
        self.trackModelMapper = trackModelMapper
    }
    
    func mapAPIToUI (apiAlbumDetails: APIAlbumDetailsModel) -> AlbumDetailsModel {
        
        let imageUrl = apiAlbumDetails.images.filter({$0.size == "large"}).first?.text
        let apiTracks = apiAlbumDetails.tracks.tracks
        
        let mapper = TrackModelMapper()

        return AlbumDetailsModel(id: apiAlbumDetails.mbid ?? "",
                                 name: apiAlbumDetails.name,
                                 artist: apiAlbumDetails.artist.name,
                                 imageURl: URL(string: imageUrl ?? ""),
                                 tracks: apiTracks.map(mapper.mapAPIToUI))
        
    }
    
    func mapUIToDB(album: AlbumDetailsModel) -> DBAlbumDetailsModel {
        
        let mapper = TrackModelMapper()
        
        let tracks = album.tracks
        let dbTracks = List<DBTrackModel>()
        dbTracks.append(objectsIn: tracks.map { mapper.mapUIToDB(track: $0) })
        
        let dbAlbum = DBAlbumDetailsModel()
        dbAlbum.id = album.id
        dbAlbum.name = album.name
        dbAlbum.artist = album.artist
        dbAlbum.images = album.imageURl?.absoluteString ?? ""
        dbAlbum.tracks = dbTracks
        
        return dbAlbum
        
    }
    
    func mapDBToUi(dbAlbumDetails: DBAlbumDetailsModel) -> AlbumDetailsModel {
        
        let mapper = TrackModelMapper()
        
        let tracks: [TrackModel] = dbAlbumDetails.tracks.map(mapper.mapDBtoUI)
        
        let albumDetailsModel = AlbumDetailsModel(id: dbAlbumDetails.id,
                                                  name: dbAlbumDetails.name,
                                                  artist: dbAlbumDetails.artist,
                                                  imageURl: URL(string: dbAlbumDetails.images),
                                                  tracks: tracks)
        
        return albumDetailsModel
        
    }
    
}


