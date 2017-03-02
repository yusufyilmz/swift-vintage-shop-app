//
//  FavouriteProductArchiver.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/3/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class FavouriteProductArchiver: NSObject {

    
    public static func unarchive () -> [Int] {
        if let data = UserDefaults.standard.object(forKey: "favouriteProducts") as? NSData {
            let favouriteProducts = NSKeyedUnarchiver.unarchiveObject(with: data as Data)
            
            return favouriteProducts as! [Int]
        }
        
        return []
    }
    
    
    public static func archive(product: Int) {
        var products = unarchive()
        products.append(product)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: products)
        UserDefaults.standard.set(data, forKey: "favouriteProducts")
    }
}
