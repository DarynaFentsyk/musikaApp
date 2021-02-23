//
//  RealmExtensions.swift
//  musikaApp
//
//  Created by Daryna Fentsyk on 06.12.20.
//
//
// import Foundation
// import RealmSwift
//
// extension Realm {
//    static func safeInit() -> Realm? {
//        do {
//            let realm = try Realm()
//            return realm
//        } catch {
//            print("Could not access database")
//        }
//        return nil
//    }
//    func safeWrite(_ block: () -> ()) {
//        do {
//            // Async safety, to prevent "Realm already in a write transaction" Exceptions
//            if !isInWriteTransaction {
//                try write(block)
//            }
//        } catch {
//            print("Could not write to database")
//        }
//    }
// }
