//
//  RestaurantModel.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var cuisine = ""
    @objc dynamic var restaurantDescription = ""
    @objc dynamic var location = ""
    @objc dynamic var image: Data?
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
    convenience init(id: Int, name: String, rating: Double, cuisine: String, restaurantDescription: String, location: String, image: Data){
        self.init()
        self.id = id
        self.name = name
        self.rating = rating
        self.cuisine = cuisine
        self.restaurantDescription = restaurantDescription
        self.location = location
        self.image = image
    }
}
