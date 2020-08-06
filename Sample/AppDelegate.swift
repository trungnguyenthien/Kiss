//
//  AppDelegate.swift
//  Kiss
//
//  Created by Trung on 7/11/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import UIKit
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let Storyboard  = UIStoryboard(name: "Main", bundle: nil)
        let vc = Storyboard.instantiateViewController(withIdentifier: "main")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = vc
        window!.makeKeyAndVisible()
        return true
    }


}

