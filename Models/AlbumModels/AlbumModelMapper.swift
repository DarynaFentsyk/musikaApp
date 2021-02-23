//
//  AlbumDetailsMapper.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 04.02.21.
//

import Foundation
import RealmSwift

protocol AlbumModelMapperProtocol {
    
    func mapAPIToUI(apiAlbum: APIAlbumModel) -> AlbumModel
    func mapAPIToUI(apiAlbumDetail: APIAlbumDetailsModel) -> AlbumModel
    func mapUIToDB(album: AlbumModel) -> DBAlbumDetailsModel
    func mapDBToUi(dbAlbum: DBAlbumDetailsModel) -> AlbumModel
}

final class AlbumModelMapper {
    
    private let trackModelMapper: TrackModelMapperProtocol
    
    init(trackModelMapper: TrackModelMapperProtocol) {
        self.trackModelMapper = trackModelMapper
    }
}

extension AlbumModelMapper: AlbumModelMapperProtocol {
    
    func mapAPIToUI (apiAlbum: APIAlbumModel) -> AlbumModel {
        
        let imageUrl = apiAlbum.images?.filter { $0.size == "large" } .first?.text
        
        let album = AlbumModel(id: apiAlbum.mbid ?? "",
                               name: apiAlbum.name,
                               artist: apiAlbum.artist.name,
                               imageUrl: URL(string: imageUrl ?? ""),
                               tracks: nil
        )
        return album
    }
    
    func mapAPIToUI(apiAlbumDetail: APIAlbumDetailsModel) -> AlbumModel {
        
        let imageUrl = apiAlbumDetail.images?.filter { $0.size == "large" } .first?.text
        let apiTracks = apiAlbumDetail.tracks?.tracks ?? []
        let album = AlbumModel(id: apiAlbumDetail.mbid ?? "",
                               name: apiAlbumDetail.name,
                               artist: apiAlbumDetail.artist,
                               imageUrl: URL(string: imageUrl ?? ""),
                               tracks: apiTracks.map { self.trackModelMapper.mapAPIToUI(apiTrack: $0) }
        )
        return album
    }
    
    func mapUIToDB(album: AlbumModel) -> DBAlbumDetailsModel {
        
        let mapper = TrackModelMapper()
        let tracks = album.tracks ?? []
        let dbTracks = List<DBTrackModel>()
        dbTracks.append(objectsIn: tracks.map { mapper.mapUIToDB(track: $0) })
        
        let dbAlbum = DBAlbumDetailsModel()
        dbAlbum.id = album.id
        dbAlbum.name = album.name
        dbAlbum.artist = album.artist
        dbAlbum.images = album.imageUrl?.absoluteString ?? ""
        dbAlbum.tracks = dbTracks
        return dbAlbum
    }
    
    func mapDBToUi(dbAlbum: DBAlbumDetailsModel) -> AlbumModel {
        
        let mapper = TrackModelMapper()
        let tracks: [TrackModel] = dbAlbum.tracks.map(mapper.mapDBtoUI)
        let album = AlbumModel(id: dbAlbum.id,
                               name: dbAlbum.name,
                               artist: dbAlbum.artist,
                               imageUrl: URL(string: dbAlbum.images),
                               tracks: tracks
        )
        return album
    }
}
