//
//  YSBrandTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSBrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandImage:UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setBrand(brand: BrandModel) {
        let image = UIImage(data: brand.ImageContent as! Data)
        brandImage?.image = image
        
   //     brandImage?.sd_setImage(with: URL(string: brand.ImageUrl!))

    }
    
    
    func setBrandDictionary(_ dict: NSDictionary) {
        // Set up the cell based on the values of the dictionary that we've been passed
            
        // Extract image URL and set that too...
        var imageUrl = ""
        
        if let images = dict.value(forKey: "images") as? NSArray {
            if (images.firstObject != nil) {
                let obj = images.firstObject as? NSDictionary
                if let urlKey = obj?.value(forKeyPath: "url.https") {
                    imageUrl = urlKey as! String
                }
                
            }
        }
        
     //   brandImage?.sd_setImage(with: URL(string: imageUrl))
        
        
    }
}
