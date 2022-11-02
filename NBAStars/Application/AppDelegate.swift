//
//  AppDelegate.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [
            tabBarItem(PlayerViewController(), title: "Recommendation", image: "doc.text.image"),
            tabBarItem(TeamViewController(), title: "Detail", image: "square.stack.3d.up")
        ]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func tabBarItem(
        _ viewController: UIViewController,
        title: String,
        image: String
    ) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = UIImage(systemName: image)
        navigation.tabBarItem.selectedImage = UIImage(systemName: image+".fill")
        navigation.navigationBar.prefersLargeTitles = true
        
        viewController.title = title
        return navigation
    }
    
    func checkVersion(remoteVersion: String) {
        if let version = UserDefaults.standard.version, version == remoteVersion {
            return
        }
        UserDefaults.standard.version = remoteVersion
        // save the new remote version
        // then, start re-fetch all data again
    }
}

