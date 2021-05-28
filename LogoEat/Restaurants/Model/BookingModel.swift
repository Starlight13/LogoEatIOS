//
//  BookingModel.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation
import RealmSwift

class Booking: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var numberOfPeople = 0
    @objc dynamic var date = Date(timeIntervalSince1970: 1)
    @objc dynamic var restaurant: Restaurant?
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Booking.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    convenience init(name: String, numberOfPeople: Int, date: Date, restaurant: Restaurant){
        self.init()
        self.id = incrementID()
        self.name = name
        self.numberOfPeople = numberOfPeople
        self.date = date
        self.restaurant = restaurant
    }
}
