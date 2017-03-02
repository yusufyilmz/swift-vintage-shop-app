//
//  YSSearchCollectionViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 11/15/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel:UILabel?

    @IBOutlet weak var collectionImage:UIImageView?

    
   // @IBOutlet fileprivate weak var cellName: UILabel!
    
    
    func setText(text: String)  {
        productNameLabel?.text = text
    }
    
//    func setBrandProperties(model: BrandModel)  {
//        productNameLabel?.text = model.Title
//       // productButton.tag = model.ID!
//        productNameLabel?.tag = model.ID!
//        let image = UIImage(data: model.ImageContent as! Data)
//        collectionImage?.image = image
//        
//        collectionImage?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
//        collectionImage?.contentMode = UIViewContentMode.scaleAspectFit
//        
//        collectionImage?.contentMode = .scaleToFill
//        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
//        collectionImage?.layer.shadowOpacity = 0.3
//        collectionImage?.layer.shadowRadius = 6
//        
//        collectionImage?.clipsToBounds = true
//    }
//    
    func setCollectionProperties(model: StoreModel)  {
       
        productNameLabel?.text = model.Title
        productNameLabel?.tag = model.ID!
       // productButton.tag = model.ID!
                
        let image : UIImage = UIImage(data: model.ImageContent as! Data)!
        collectionImage?.image = image

        
        collectionImage?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
        collectionImage?.contentMode = UIViewContentMode.scaleAspectFit
        
        collectionImage?.contentMode = .scaleToFill
        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
        collectionImage?.layer.shadowOpacity = 0.3
        collectionImage?.layer.shadowRadius = 6
        
        collectionImage?.clipsToBounds = true
    }
//    }
//    
//    func setMainCollectionProperties(model: CollectionModel)  {
//        productNameLabel?.text = model.Title
//        productNameLabel?.tag = model.ID!
//        // productButton.tag = model.ID!
//        
//        let image : UIImage = UIImage(data: model.ImageContent as! Data)!
//        collectionImage?.image = image
//        
//        
//        collectionImage?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
//        collectionImage?.contentMode = UIViewContentMode.scaleAspectFit
//        
//        collectionImage?.contentMode = .scaleToFill
//        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
//        collectionImage?.layer.shadowOpacity = 0.3
//        collectionImage?.layer.shadowRadius = 6
//        
//        collectionImage?.clipsToBounds = true
//        
//    }

    
    
    
}
