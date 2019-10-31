//
//  AppDelegate.swift
//  Notes
//
//  Created by tranthanh on 10/4/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       window = UIWindow(frame: UIScreen.main.bounds)
       window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController:
            NotesController())
        return true
    }

   

}

