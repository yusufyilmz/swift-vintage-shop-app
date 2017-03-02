//
//  MainHeadModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/9/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class MainHeadModel: NSObject, StoreModel {
    
    var ID: Int?
    var Slug: String?
    var Status: Int?
    var Title: String?
    var Description: String?
    var ImageName: String?
    var ImageContent: NSData?
    var Row: Int?

    
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
