//
//  UsersListViewController.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 4/7/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit

final class UsersListViewController: UIViewController {
    
    // MARK: Properties
    
    private var users: [User] = []
    private var observer: NSKeyValueObservation?
    
    // MARK: Outlets
    
    @IBOutlet private var usersTableView: UITableView!
    
    // MARK: Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(self.addNewUser))
        
        self.beginObservingUserUpdates()
    }
    
    // MARK: KVO
    
    /// Creates an observer for the stored array of `Users` and calls `reloadData` on table view whenever the users array changes.
    private func beginObservingUserUpdates() {
        self.observer = UserDefaults.standard.observe(\UserDefaults.users, options: .initial) { [weak self] _, _ in
            self?.users = UserDefaults.standard.users
            self?.usersTableView.reloadData()
        }
    }
    
    // MARK: Button Actions
    
    @objc
    private func addNewUser() {
        let viewController = CreateUserViewController.fromStoryboard()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UITableViewDelegate

extension UsersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        let viewController = ViewUserDetailsViewController.fromStoryboard()
        viewController.inject(firstName: user.firstName, lastName: user.lastName)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UITableViewDataSource

extension UsersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as? UserTableViewCell else {
            fatalError()
        }
        cell.userFullName = self.users[indexPath.row].fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserTableViewCell.height
    }
    
    
}
