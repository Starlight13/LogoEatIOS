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
        
        NetworkService.shared.getData(request: request) { (json) in
            guard let jsonArray = json as? [[String: Any]] else { return }
            completion(jsonArray)
        }
    }
}
