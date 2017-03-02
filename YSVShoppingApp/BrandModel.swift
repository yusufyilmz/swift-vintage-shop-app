//
//  BrandModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/25/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import Foundation

class BrandModel: NSObject, StoreModel {
    
    
    var ID: Int?
    var Slug: String?
    var Status: Int?
    var Live: String?
    var Title: String?
    var Description: String?
    var ImageName: String?
    var ImageContent: NSData?

    
    override init()
    {
        
    }
    
    init(slug: String, live: String, title: String, description: String, imageurl: String) {
        
        self.Slug = slug
        self.Live = live
        self.Title = title
        self.Description = description
       // self.ImageUrl = imageurl
    }
    
    
    //prints object's current state
    
//    override var description: String: String {
//        return "slug: \(Slug), live: \(Live), title: \(Title), description: \(Description)"
//        
//    }
//    
    
}
