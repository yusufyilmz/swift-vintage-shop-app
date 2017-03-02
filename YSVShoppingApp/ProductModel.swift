//
//  BrandModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/25/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import Foundation

class ProductModel: NSObject, StoreModel {
    
    //properties
    var ID: Int?
    var Slug: String?
    var Status: Int?
    var Title: String?
    var Description: String?
    var CollectionId: Int?
    var BrandId: Int?
    var Price: Double?
    var Stock: Int?
    var Favourited:Bool?
    var ImageName: String?
    var ImageContent: NSData?
    //empty constructor
    

    override init () {
        
    }
    
    init(slug: String, status: Int, title: String, description: String, imageurl: String , collectionId: Int, id: Int, brandId: Int, price: Double, stock: Int) {
        
        
        self.Slug = slug
        self.Status = status
        self.Title = title
        self.Description = description
        self.BrandId = brandId
        self.CollectionId = collectionId
        self.Price = price
        self.Stock = stock
        self.ID = id
    }
    
    
    //prints object's current state
    
    //    override var description: String: String {
    //        return "slug: \(Slug), live: \(Live), title: \(Title), description: \(Description)"
    //
    //    }
    //    
    
}
