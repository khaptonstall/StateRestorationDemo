//
//  ViewUserDetailsViewController.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 3/24/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import UIKit

final class ViewUserDetailsViewController: UIViewController {
        
    // MARK: Outlets
    
    @IBOutlet private var firstNameLabel: UILabel!
    @IBOutlet private var lastNameLabel: UILabel!
    
    // MARK: Properties
    
    private var firstName: String?
    private var lastName: String?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User Details"
        self.firstNameLabel.text = self.firstName
        self.lastNameLabel.text = self.lastName
    }
    
    // MARK: Dependency Injection
    
    func inject(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

    // MARK: Helpers
    
    /// A convenience method to create an instance of `ViewUserDetailsViewController` from the storyboard.
    static func fromStoryboard() -> ViewUserDetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "ViewUserDetailsViewController") as! ViewUserDetailsViewController
    }
}

