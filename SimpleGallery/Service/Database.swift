//
//  Database.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Database {
    
    private var db = Firestore.firestore()
    
    // Default Database Paths. Collections in this case
    enum Path: String {
        case images = "images"
    }
    
    /// Save data to database
    ///
    /// - Parameters:
    ///   - data: Dictionary representing data to save
    ///   - id: String to be used as data identifier
    ///   - path: Default path to save the data
    ///   - completion: block invoqued at the end of the proccess. Return error:Error if operation fails
    func save(data: [String: Any], id: String, path: Path, completion: ((_ error: Error?) -> Void)?) {
        self.db.collection(path.rawValue).document(id).setData(data, completion: completion)
    }
    
    /// Fetch data from database
    ///
    /// - Parameters:
    ///   - path: Default path where to retrive from
    ///   - completion: block invoqued at the end of the proccess. Return Array of Dictionaries or nil if opetation fails
    func fetch(path: Path, completion: @escaping ((_ result: Array<[String: Any]>?) -> Void)) {
        self.db.collection(path.rawValue).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            completion(snapshot.documents.compactMap({$0.data()}))            
        }
    }
    
    /// Delete data from database
    ///
    /// - Parameters:
    ///   - id: String identifier of the data
    ///   - path: Default path where the data is located
    ///   - completion: block invoqued at the end of the proccess. Return error:Error is operation fails
    func delete(with id: String, path: Path, completion: ((_ error: Error?) -> Void)?) {
        self.db.collection(path.rawValue).document(id).delete(completion: completion)
    }
    
}

extension Database {
    
    /// Gererate a new data identifier
    ///
    /// - Returns: String identifier
    func generateID() -> String {
        return self.db.collection(Path.images.rawValue).document().documentID
    }
}
