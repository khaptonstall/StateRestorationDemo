//
//  SceneDelegate.swift
//  StateRestorationDemo
//
//  Created by Kyle Haptonstall on 3/24/20.
//  Copyright © 2020 Kyle Haptonstall. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // We want to prefer the user activities which are handed to us via Handoff or any other system facilities that vend us
        // user activities since the user initiated these actions before falling back on the stateRestorationActivity.
        if let userActivity = connectionOptions.userActivities.first ?? session.stateRestorationActivity {
            self.restoreState(with: userActivity, window: self.window)
        }
    }
    
    private func restoreState(with activity: NSUserActivity, window: UIWindow?) {
        guard let navigationController = window?.rootViewController as? UINavigationController else {
            return
        }
        
        let createUserViewController = CreateUserViewController.fromStoryboard()
        navigationController.pushViewController(createUserViewController, animated: false)
        createUserViewController.restoreUserActivityState(activity)
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        guard let window = self.window else {
            return
        }
        
        if let navController = window.rootViewController as? UINavigationController {
            if let createUserViewController = navController.viewControllers.last as? CreateUserViewController {
                // Fetch the user activity from our create user view controller to restore for later.
                scene.userActivity = createUserViewController.createUserUserActivity
            }
        }
    }
    
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        return scene.userActivity
    }


}

