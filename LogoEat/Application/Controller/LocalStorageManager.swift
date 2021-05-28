//
//  LocalStorageManager.swift
//  LogoEat
//
//  Created by dsadas asdasd on 28.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import RealmSwift



let realm = try! Realm()

class LocalStorageManager {
    
    static func saveObject (_ booking: Booking) {
        try! realm.write {
            realm.add(booking, update: .modified)
        }
    }
    
    static func deleteObject(_ booking: Booking) {
        try! realm.write{
            realm.delete(booking)
        }
    }
    
}
