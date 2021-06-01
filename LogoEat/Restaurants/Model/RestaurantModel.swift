//
//  RestaurantModel.swift
//  LogoEat
//
//  Created by dsadas asdasd on 16.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object, Codable {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var rating = 0.0
    @objc dynamic var cuisine = "Ukrainian, Italian"
    @objc dynamic var restaurantDescription = ""
    @objc dynamic var location = ""
    @objc dynamic var image: Data?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case cuisine
        case restaurantDescription = "description"
        case location = "address"
        case image
    }
    
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
    
    convenience init(_ dictionary: [String: Any]) {
        self.init()
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.rating = dictionary["rating"] as? Double ?? 0
        self.cuisine = "Ukrainian, Italian"
        self.restaurantDescription = dictionary["description"] as? String ?? ""
        self.location = dictionary["address"] as? String ?? ""
        let url = URL(string: dictionary["mainImageLink"] as! String)
        let imageData = try? Data(contentsOf: url!)
        self.image = imageData
    }
}
