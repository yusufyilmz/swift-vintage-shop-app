//
//  AppGlobals.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/26/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit


class AppGlobals: NSObject {
    static let sharedInstance = AppGlobals()

    var spinWindow: UIWindow!
    
    //Setting and getting AppDelegate window
    func setSpinnerWindow(win: UIWindow){
        spinWindow = win
    }
    
    func getSpinnerWindow() -> UIWindow {
        return spinWindow
    }
}
