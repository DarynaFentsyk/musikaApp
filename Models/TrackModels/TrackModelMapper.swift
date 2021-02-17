//
//  TrackModelMapper.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 04.02.21.
//

import Foundation

protocol TrackModelMapperProtocol {
    
    func mapAPIToUI (apiTrack: APITrackModel) -> TrackModel
    func mapUIToDB(track: TrackModel) -> DBTrackModel
    func mapDBtoUI(dbTrack: DBTrackModel) -> TrackModel
}

final class TrackModelMapper: TrackModelMapperProtocol {
    
    func mapAPIToUI(apiTrack: APITrackModel) -> TrackModel {
        
        let trackModelMapper = TrackModel(name: apiTrack.name)
        return trackModelMapper
    }
    
    func mapUIToDB(track: TrackModel) -> DBTrackModel {
        
        let dbTrack = DBTrackModel()
        dbTrack.name = track.name
        return dbTrack
    }
    
    func mapDBtoUI(dbTrack: DBTrackModel) -> TrackModel {
        
        let tracks = TrackModel(name: dbTrack.name)
        return tracks
    }
}
