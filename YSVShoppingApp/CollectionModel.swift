//
//  CollectionModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/25/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class CollectionModel: NSObject, StoreModel {
    
    var ID: Int?
    var Slug: String?
    var Status: Int?
    var Title: String?
    var Description: String?
    var ImageName: String?
    var ImageContent: NSData?
    
    override init()
    {

    }
    
    
    init(id: Int, slug: String, status: Int, title: String, description: String, imageurl: String) {
        
        self.ID = id
        self.Slug = slug
        self.Status = status
        self.Title = title
        self.Description = description
    }
    

}
