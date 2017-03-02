//
//  UserModel.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/7/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    
    var ID: Int?
    var LoginId: String?
    var Name: String?
    var LastName: String?
    var FirstName: String?
    var Email: String?
    var PictureLink: String?
    
    override init () {
        
    }
    
    
 
    
    func toJson() -> String {
        return
            "{\"LoginId\": \"\(self.LoginId!)\"," +
              "\"Name\": \"\(self.Name!)\"," +
              "\"FirstName\": \"\(self.FirstName!)\"," +
              "\"LastName\": \"\(self.LastName!)\"," +
              "\"Email\": \"\(self.Email!)\"}"
    }


    func toDictionary() -> Dictionary<String, String> {
        
        var dic = Dictionary<String, String>()
        dic["LoginId"] = self.LoginId!
        dic["Name"] = self.Name!
        dic["FirstName"] = self.FirstName!
        dic["LastName"] = self.LastName!
        dic["Email"] = self.Email!

        return dic
    }
}
