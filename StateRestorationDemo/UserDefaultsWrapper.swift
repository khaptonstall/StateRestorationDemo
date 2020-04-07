//
//  UserDefaultsWrapper.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 4/7/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private static let usersKey = "Users"
    
    @objc
    dynamic var users: [User] {
        get {
            guard let userData = UserDefaults.standard.value(forKey: UserDefaults.usersKey) as? Data else {
                return []
            }
            return try! JSONDecoder().decode([User].self, from: userData)
        }
        set {
            let data = try! JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(data, forKey: UserDefaults.usersKey)
        }
    }

}

