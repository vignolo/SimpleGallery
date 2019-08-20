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
    
    enum Path: String {
        case images = "images"
    }
    
    func save(data: [String: Any], path: Path, completion: ((_ error: Error?) -> Void)?) {
        self.db.collection(path.rawValue).addDocument(data: data, completion: completion)
    }
    
    func fetch(path: Path, completion: @escaping ((_ result: Array<[String: Any]>?) -> Void)) {
        self.db.collection(path.rawValue).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                completion(nil)
                return
            }
            
            completion(snapshot.documents.compactMap({$0.data()}))            
        }
    }
    
}

extension Database {
    func generateID() -> String {
        return self.db.collection(Path.images.rawValue).document().documentID
    }
}
