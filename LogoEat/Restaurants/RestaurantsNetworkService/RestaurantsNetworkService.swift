//
//  RestaurantsNetworkService.swift
//  LogoEat
//
//  Created by dsadas asdasd on 01.06.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation

class RestaurantsNetworkService {
    
    private init() {}
    static func getRestaurants(completion: @escaping(_ dict: [[String: Any]]) -> ()) {
        guard let url = URL(string: "\(apiEndpoints.baseURL)/restaurants") else {print("Localhost"); return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
        
        NetworkService.shared.getData(request: request) { (json, response) in
            guard let jsonArray = json as? [[String: Any]] else { return }
            completion(jsonArray)
        }
    }
    
    static func bookRestaurant(restaurantId: Int, bookingDate: Int64, userName: String, numberOfPeople: Int, completion: @escaping(_ dict: [String: Any]) -> ()) {
        guard let url = URL(string: "\(apiEndpoints.baseURL)/booking") else {print("Localhost"); return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "restaurantId": restaurantId,
            "bookingDate": bookingDate,
            "userName": userName,
            "peopleAmount": numberOfPeople
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
        
        NetworkService.shared.getData(request: request) { (data, response) in
            guard let json = data as? [String: Any] else { return }
            completion(json)
        }
    }
}
