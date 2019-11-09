//
//  AppDelegate.swift
//  ChatBubbleAdvanced
//
//  Created by Dima on 3/10/18.
//  Copyright © 2018 Dima Nikolaev. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userActivityObj:user_activity!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if userLoginStatus, let _ = Auth.auth().currentUser{
            self.userActivityObj = user_activity()
            self.userActivityObj.isUserActive(isActive: true, completion: {(error) in
                if let err = error{
                    let navigationController = application.windows[0].rootViewController as! UINavigationController
                    let activeViewCont = navigationController.visibleViewController
                    let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    activeViewCont!.present(alert, animated: true, completion: nil)
                }
            })
            RouteManager.shared.showHome()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.userActivityObj = user_activity()
        self.userActivityObj.isUserActive(isActive: false, completion: {(error) in
            if let err = error{
                let navigationController = application.windows[0].rootViewController as! UINavigationController
                let activeViewCont = navigationController.visibleViewController
                let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                activeViewCont!.present(alert, animated: true, completion: nil)
            }
        })
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        self.userActivityObj = user_activity()
        self.userActivityObj.isUserActive(isActive: true, completion: {(error) in
            if let err = error{
                let navigationController = application.windows[0].rootViewController as! UINavigationController
                let activeViewCont = navigationController.visibleViewController
                let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                activeViewCont!.present(alert, animated: true, completion: nil)
            }
        })
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.userActivityObj = user_activity()
        self.userActivityObj.isUserActive(isActive: false, completion: {(error) in
            if let err = error{
                let navigationController = application.windows[0].rootViewController as! UINavigationController
                let activeViewCont = navigationController.visibleViewController
                let alert = UIAlertController(title: "Alert", message: err, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                activeViewCont!.present(alert, animated: true, completion: nil)
            }
        })
    }


}

