//
//  DBManager.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 23/02/2023.
//

import RealmSwift

class DBManager {
    
    static let shared = DBManager()
    let realm = try! Realm()
    
    /// Delete Database table
    func deleteDatabase() {
        try! realm.write({
            realm.deleteAll()
        })
    }
    
    /// Delete Single Object
    /// - Parameters:
    ///   - object: Object to be deleted

    func deleteObject(object: Object) {
        try? realm.write ({
            realm.delete(object)
        })
    }
    
    /// Add Single Object
    /// - Parameters:
    ///   - object: Object to be added
    func saveObject(object: Object) {
        try! realm.write ({
            realm.add(object, update: .modified)
            
        })
    }
        
    /// Returs an array as Results<object>?
    /// - Parameters:
    ///   - object: Object to be added
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm.objects(type)
    }
    
}
