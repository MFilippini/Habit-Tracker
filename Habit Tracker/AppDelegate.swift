//
//  AppDelegate.swift
//  Habit Tracker
//
//  Created by Michael Filippini on 7/5/18.
//  Copyright © 2018 Michael Filippini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "Left") as! MenuViewController
        
        //let nvc = storyboard.instantiateViewController(withIdentifier: "Nav") as! UINavigationController
        
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        nvc.navigationBar.barStyle = .black
        nvc.navigationBar.alpha = 1
        let colorVal: CGFloat = 27
        
        nvc.navigationBar.backgroundColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nvc.navigationBar.barTintColor = UIColor(red: colorVal/255.0, green: colorVal/255.0, blue: colorVal/255.0, alpha: 1)
        nvc.navigationBar.tintColor = .white
        
        leftViewController.mainVC = nvc
        
        let slideMenuController = SlideMenuController(mainViewController: nvc, leftMenuViewController: leftViewController)
        
        
        self.window?.rootViewController = slideMenuController
        self.window?.backgroundColor = darkGrey
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

