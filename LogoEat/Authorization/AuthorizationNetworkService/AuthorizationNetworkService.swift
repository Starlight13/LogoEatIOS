//
//  AuthorizationNetworkService.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation


class AuthorizationNetworkService {
    private init() {}
    static func login(email:String, password:String, completion: @escaping(_ dict: [String:Any]) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8080/login") else {print("Localhost"); return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
            }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        NetworkService.shared.getData(request: request) { (json) in
            guard let dict = json as? [String: Any] else {return}
            completion(dict)
        }
    }
}
