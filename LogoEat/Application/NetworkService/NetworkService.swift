//
//  NetworkService.swift
//  LogoEat
//
//  Created by dsadas asdasd on 18.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func getData(request: URLRequest, completion: @escaping (Any, HTTPURLResponse) -> ()) {
        let session = URLSession.shared
        
        session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else {return}
            let httpResponse = response as! HTTPURLResponse
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(httpResponse)
                completion(json, httpResponse)
            } catch {
                print(error)
            }
        }.resume()
    }
}
