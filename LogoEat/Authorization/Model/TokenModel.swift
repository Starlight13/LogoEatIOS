//
//  UserModel.swift
//  LogoEat
//
//  Created by dsadas asdasd on 17.05.2021.
//  Copyright © 2021 dsadas asdasd. All rights reserved.
//

import Foundation

final class Token {
    private enum SettingsKeys: String{
        case token
    }
    
    
    static var token: String! {
        get{
            return UserDefaults.standard.string(forKey: SettingsKeys.token.rawValue)
        }
        set{
            let defaults = UserDefaults.standard
            let key = SettingsKeys.token.rawValue
            guard let token = newValue else { defaults.removeObject(forKey: key); return}
            defaults.set(token, forKey: "token")
        }
    }
}
