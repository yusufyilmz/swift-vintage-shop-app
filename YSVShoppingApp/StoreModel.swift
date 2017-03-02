//
//  StoreModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/9/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

protocol StoreModel {

    var ID: Int? {get set}
    var Slug: String? {get set}
    var Status: Int? {get set}
    var Title: String? {get set}
    var Description: String? {get set}
    var ImageName: String? {get set}
    var ImageContent: NSData? {get set}
}
