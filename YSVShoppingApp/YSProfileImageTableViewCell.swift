//
//  YSProfileImageTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/8/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import SwiftSpinner
import FacebookCore

class YSProfileImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePictureView:UIImageView?
    @IBOutlet weak var profileName:UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    
    func setLoginCellWithImage(button: LoginButton, userModel: UserModel) {
        
        
        button.frame = CGRect(x: 100, y: 300, width: 150, height: 50)
        //button.center = self.center
        
        
        button.center = CGPoint(x: self.center.x, y: self.center.y + 100)

        
      //  button.center =  self.center + CGPoint(x) CGPointMake(yourView.frame.size.width  / 2,
        //                                           yourView.frame.size.height / 2);
        self.addSubview(button)
        
        profilePictureView?.layer.borderWidth = 1.0
        profilePictureView?.layer.masksToBounds = false
        profilePictureView?.layer.borderColor = UIColor.black.cgColor
        profilePictureView?.layer.cornerRadius = (profilePictureView?.frame.size.height)!/2
        profilePictureView?.clipsToBounds = true
        
        
        

        profilePictureView?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
        profilePictureView?.contentMode = UIViewContentMode.scaleAspectFit
        
        profilePictureView?.contentMode = .scaleToFill
        profilePictureView?.layer.shadowOffset = CGSize(width: 10, height: 20)
        profilePictureView?.layer.shadowOpacity = 0.3
        profilePictureView?.layer.shadowRadius = 6
        profilePictureView?.center = CGPoint(x: self.center.x, y: self.center.y - 50.0)
        profileName?.center = CGPoint(x: self.center.x, y: self.center.y + 50.0 )
 
        
        
        if(userModel.PictureLink != nil && userModel.PictureLink != "" ) {
            
            let pictureURL = URL(string: userModel.PictureLink!)
            let imageData = NSData(contentsOf: pictureURL!)
            profilePictureView?.image = UIImage(data: imageData! as Data)
            
            
            profileName?.text = userModel.Name
            
        }
        else {
            profilePictureView?.image = UIImage(named: "noprofile")
            profileName?.text = ""
            
     
            
            
        }
        
        
        
    }
    
    
    
  
}
