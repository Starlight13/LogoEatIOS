//
//  SettingsNetworkService.swift
//  LogoEat
//
//  Created by dsadas asdasd on 27.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation

class SettingsNetworkService {
    private init() {}
    
    static func makeChangeRequest(parameters: [String: Any], requestUrl: String, completion: @escaping(_ dict: [String:Any]) -> ()){
        guard let url = URL(string: "\(apiEndpoints.baseURL)/\(requestUrl)") else {print("Localhost"); return}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
        
        NetworkService.shared.getData(request: request) { (json, response) in
            guard let dict = json as? [String: Any] else {return}
            completion(dict)
        }
    }
//    static func changeName(name:String, completion: @escaping(_ dict: [String:Any]) -> ()) {
//        guard let url = URL(string: "\(apiEndpoints.baseURL)/update_name") else {print("Localhost"); return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        let parameters: [String: Any] = [
//            "name": name
//        ]
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
//        
//        NetworkService.shared.getData(request: request) { (json) in
//            guard let dict = json as? [String: Any] else {return}
//            completion(dict)
//        }
//    }
//    
//    static func changePhoneNumber(phoneNumber:String, completion: @escaping(_ dict: [String:Any]) -> ()) {
//        guard let url = URL(string: "\(apiEndpoints.baseURL)/update_phone_number") else {print("Localhost"); return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        let parameters: [String: Any] = [
//            "phoneNumber": phoneNumber
//        ]
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
//        
//        NetworkService.shared.getData(request: request) { (json) in
//            guard let dict = json as? [String: Any] else {return}
//            completion(dict)
//        }
//    }
//    
//    static func changePassword(password:String, completion: @escaping(_ dict: [String:Any]) -> ()) {
//        guard let url = URL(string: "\(apiEndpoints.baseURL)/update_password") else {print("Localhost"); return}
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        let parameters: [String: Any] = [
//            "password": password
//        ]
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("Bearer \(Token.token!)", forHTTPHeaderField: "Authorization")
//        
//        NetworkService.shared.getData(request: request) { (json) in
//            guard let dict = json as? [String: Any] else {return}
//            completion(dict)
//        }
//    }
}
