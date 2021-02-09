//
//  DBService.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 08.02.21.
//

import RealmSwift

protocol DataBaseServiceProtocol {
    
    func saveAlbum (dbAlbum: DBAlbumDetailsModel, completion: @escaping ErrorHandler)
    func deleteAlbum (id: String, completion: @escaping ErrorHandler)
    func getAlbum() -> [DBAlbumDetailsModel]
    func isAlbumSaved(id: String) -> Bool
}

final class DataBaseService {
    
    private let realm: Realm
    
    init?(configuration: Realm.Configuration) {
        
        guard let  realm = try? Realm(configuration: configuration) else {
            return nil
        }
        self.realm = realm
    }
}

extension DataBaseService: DataBaseServiceProtocol {
    
    func saveAlbum (dbAlbum: DBAlbumDetailsModel, completion: @escaping ErrorHandler) {
        
        do {
            try self.realm.write {
                self.realm.add(dbAlbum, update: .all)
            }
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func deleteAlbum (id: String, completion: @escaping ErrorHandler) {
        
        guard let album = self.getAlbum().filter({$0.id == id}).first else {
            completion(nil)
            return
        }
        
        do {
            try self.realm.write {
                self.realm.delete(album)
            }
            completion(nil)
        } catch {
            completion(error)
            }
        
    }
    
    func getAlbum() -> [DBAlbumDetailsModel] {
        Array(self.realm.objects(DBAlbumDetailsModel.self))
    }
    
    func isAlbumSaved(id: String) -> Bool {
        self.realm.object(ofType: DBAlbumDetailsModel.self, forPrimaryKey: id) != nil
    }
}


