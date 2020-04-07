//
//  UserTableViewCell.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 4/7/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit

final class UserTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UserTableViewCell"
    static let height: CGFloat = 60
    
    var userFullName: String? {
        get {
            return self.textLabel?.text
        }
        set {
            self.textLabel?.text = newValue
        }
    }

}
