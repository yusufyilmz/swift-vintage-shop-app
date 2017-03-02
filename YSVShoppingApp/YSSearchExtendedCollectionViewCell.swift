//
//  YSSearchExtendedCollectionViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/10/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//



import UIKit

class YSSearchExtendedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel:UILabel?
    
    @IBOutlet weak var collectionImage:UIImageView?
    
    
    // @IBOutlet fileprivate weak var cellName: UILabel!
    
    
    func setText(text: String)  {
       // productNameLabel?.text = text
    }
    
    func setImage()  {
        
        let image = UIImage(named: "search")
        
        collectionImage?.image = image

    }


    func setCollectionProperties(model: StoreModel)  {
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = (productNameLabel?.bounds)!
        //productNameLabel?.addSubview(blurView)
        productNameLabel?.sendSubview(toBack: blurView)
        productNameLabel?.font = UIFont (name: "HelveticaNeue-Bold", size: 20)


        productNameLabel?.text = model.Title
        productNameLabel?.tag = model.ID!
        // productButton.tag = model.ID!
        
        let image : UIImage = UIImage(data: model.ImageContent as! Data)!
        collectionImage?.image = image
        
        collectionImage?.center = self.center
        collectionImage?.frame = self.frame
        collectionImage?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
        collectionImage?.contentMode = UIViewContentMode.scaleAspectFit
        
        collectionImage?.contentMode = .scaleToFill
        collectionImage?.layer.shadowOffset = CGSize(width: 10, height: 20)
        collectionImage?.layer.shadowOpacity = 0.3
        collectionImage?.layer.shadowRadius = 6
        
        
        collectionImage?.clipsToBounds = true
        collectionImage?.layer.cornerRadius = (collectionImage?.frame)!.width/16.0
        collectionImage?.layer.masksToBounds = true
        
        var cellPadding: CGFloat = 3.0
        var annotationHeight: CGFloat = 145.0

        
        //let height = cellPadding + annotationHeight + cellPadding
        //let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
        //let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        

    }
  
    
    
}
