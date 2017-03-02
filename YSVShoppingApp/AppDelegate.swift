//
//  AppDelegate.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import FBSDKLoginKit

//let YS_STORE_ID = "umRG34nxZVGIuCSPfYf8biBSvtABgTR8GMUtflyE"

let YS_STORE_ID = "p43pTiblJybTgr88T3qaVjpGsQkgjOJYcyQKx635zF"


let YS_LOGGING = true

// RGB: 139, 98, 181
let YS_COLOR = UIColor(red: (139.0/255.0), green: (98.0/255.0), blue: (181.0/255.0), alpha: 1.0)


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.tintColor = YS_COLOR
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    //
    //        self.window?.tintColor = YS_COLOR
    //
    //
    //      //  Moltin.sharedInstance().setPublicId(YS_STORE_ID)
    //
    //        //Moltin.sharedInstance().setLoggingEnabled(YS_LOGGING)
    //        //SwiftSpinner.show("Yükleniyor")
    //
    //        //self.window = UIWindow(frame: UIScreen.mainScreen.bounds)
    //
    //
    //        //AppGlobals.setSpinnerWindow(win: self.window!)
    //
    //
    //
    //        //ProductManager.sharedInstance.
    //
    //
    //        // Override point for customization after application launch.
    //        return true
    //    }
    
    // func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    //  }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    func switchToCartTab() {
        let tabBarController = self.window!.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 3
        
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
}


