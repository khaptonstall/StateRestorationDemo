//
//  CreateUserViewController.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 3/24/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import UIKit

final class CreateUserViewController: UIViewController {
    
    private static let UserActivityType = "com.khaptonstall.staterestorationdemo.staterestoration.createuser"
    private typealias RestorationInfo = (firstName: String?, lastName: String?)
    
    // MARK: Outlets
    
    @IBOutlet private var firstNameTextField: UITextField!
    @IBOutlet private var lastNameTextField: UITextField!
    @IBOutlet private var submitButton: UIButton!
    
    // MARK: Properties
    
    /// An `NSUserActivity` object representing the current state of the view controller.
    var createUserUserActivity: NSUserActivity {
        let userActivity = NSUserActivity(activityType: Self.UserActivityType)
        self.updateUserActivityForCurrentState(userActivity)
        return userActivity
    }
    
    /// Stored restoration info, as we may be asked to restore state prior to the IBOutlets being loaded.
    private var restorationInfo: RestorationInfo?

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Create New User"
        
        // Handle possible state restoration
        self.firstNameTextField.text = self.restorationInfo?.firstName
        self.lastNameTextField.text = self.restorationInfo?.lastName
        self.restorationInfo = nil
    }
    
    // MARK: State Restoration iOS 12 and Below

    private enum RestorationKeys: String {
        case firstName
        case lastName
    }
    
    override func encodeRestorableState(with coder: NSCoder) {
        if let firstName = self.firstNameTextField.text, !firstName.isEmpty {
            coder.encode(firstName, forKey: RestorationKeys.firstName.rawValue)
        }
        if let lastName = self.lastNameTextField.text, !lastName.isEmpty {
            coder.encode(lastName, forKey: RestorationKeys.lastName.rawValue)
        }
        
        super.encodeRestorableState(with: coder)
    }

    override func decodeRestorableState(with coder: NSCoder) {
        let firstName = coder.decodeObject(forKey: RestorationKeys.firstName.rawValue) as? String
        let lastName = coder.decodeObject(forKey: RestorationKeys.lastName.rawValue) as? String
        self.restorationInfo = (firstName, lastName)
        
        super.decodeRestorableState(with: coder)
    }
    
    // MARK: State Restoration iOS 13
    
    /// Stores the current UI information on the passed in `NSUserActivity`.
    /// - Parameter userActivity: The activity to store the UI information on.
    private func updateUserActivityForCurrentState(_ userActivity: NSUserActivity) {
        if let firstName = self.firstNameTextField.text {
            let firstNameItem: [String: String] = [RestorationKeys.firstName.rawValue: firstName]
            userActivity.addUserInfoEntries(from: firstNameItem)
        }
        if let lastName = self.lastNameTextField.text {
            let lastNameItem: [String: String] = [RestorationKeys.lastName.rawValue: lastName]
            userActivity.addUserInfoEntries(from: lastNameItem)
        }
    }
    
    override func updateUserActivityState(_ activity: NSUserActivity) {
        super.updateUserActivityState(activity)
        self.updateUserActivityForCurrentState(activity)
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        super.restoreUserActivityState(activity)
        
        self.restoreState(from: activity)
    }
    
    private func restoreState(from userActivity: NSUserActivity) {
        guard userActivity.activityType == Self.UserActivityType else {
            // We don't support the activityType.
            return
        }
        
        let activityUserInfo = userActivity.userInfo
        let firstName = activityUserInfo?[RestorationKeys.firstName.rawValue] as? String
        let lastName = activityUserInfo?[RestorationKeys.lastName.rawValue] as? String
        self.restorationInfo = (firstName, lastName)
    }
    
    // MARK: Button Actions
    
    @IBAction private func submitButtonPressed() {
        guard
            let firstName = self.firstNameTextField.text, !firstName.isEmpty,
            let lastName = self.lastNameTextField.text, !lastName.isEmpty else {
                return
        }
        
        // Store the new user in UserDefaults (our demo persistent storage).
        var users = UserDefaults.standard.users
        users.append(User(firstName: firstName, lastName: lastName))
        UserDefaults.standard.users = users
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Helpers
    
    /// A convenience method to create an instance of `CreateUserViewController` from the storyboard.
    static func fromStoryboard() -> CreateUserViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        return storyboard.instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
    }
    
}
