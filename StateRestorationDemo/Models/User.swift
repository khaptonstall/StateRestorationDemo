//
//  User.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 4/7/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import Foundation

@objc
class User: NSObject, Codable {
    
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension User {
    
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
}
