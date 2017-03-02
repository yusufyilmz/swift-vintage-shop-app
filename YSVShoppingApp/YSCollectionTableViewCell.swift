//
//  YSCollectionTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionLabel:UILabel?
    @IBOutlet weak var collectionImage:UIImageView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCollection(collection:  CollectionModel) {

        collectionLabel?.text = collection.Title
        let image : UIImage = UIImage(data: collection.ImageContent as! Data)!
         collectionImage?.image = image
        
        
        collectionImage?.contentMode = .scaleToFill
        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
        collectionImage?.layer.shadowOpacity = 0.3
        collectionImage?.layer.shadowRadius = 6
        
        collectionImage?.clipsToBounds = true
        
    }
    
    func setCollectionDictionary(_ dict: NSDictionary) {
        // Set up the cell based on the values of the dictionary that we've been passed
        
        collectionLabel?.text = dict.value(forKey: "title") as? String
        
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
        
        
     //   collectionImage?.sd_setImage(with: URL(string: imageUrl))
        collectionImage?.contentMode = .scaleToFill
        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
        collectionImage?.layer.shadowOpacity = 0.3
        collectionImage?.layer.shadowRadius = 6
        
        collectionImage?.clipsToBounds = true

    }
    
}
