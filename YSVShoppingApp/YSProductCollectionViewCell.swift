//
//  YSCollectionViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/12/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSProductCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var productNameLabel:UILabel?

    @IBOutlet weak var productPriceLabel:UILabel?
    @IBOutlet weak var productImageView:UIImageView?
    @IBOutlet weak var favouriteProductButton:UIButton?

    @IBAction func favouriteProduct(_ sender: AnyObject){
        let productId = sender.tag
        FavouriteProductArchiver.archive(product: productId!)
        favouriteProductButton?.setImage(UIImage(named: "Hearts Filled-50"), for: UIControlState.normal)

    }
    
    @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!

    
    func setImage(product: ProductModel) throws {
       
        let image: UIImage = UIImage(data: product.ImageContent as! Data)!
        productImageView?.image = image

    }
    
    
    func configureWithProduct(product:ProductModel)  {
        self.backgroundColor = UIColor.white

        productNameLabel?.text = product.Title
        productPriceLabel?.text = String(format:"%f", product.Price!)
        //try? setImage(product: product)
    
        let image: UIImage? = UIImage(data: product.ImageContent as! Data)
        productImageView?.image = image
        productImageView?.layer.borderColor = UIColor.black.cgColor
        if product.Favourited == true {
                    favouriteProductButton?.setImage(UIImage(named: "Hearts Filled-50"), for: UIControlState.normal)
        }
        else {
                    favouriteProductButton?.setImage(UIImage(named: "Hearts-50"), for: UIControlState.normal)
        }

        
        
        //productImageView?.layer.cornerRadius = (productImageView?.frame.size.width)! / 2;

        productImageView?.clipsToBounds = true
        //productImageView?.sizeToFit()
//        productImageView?.layer.shadowOffset = CGSize(width: 10, height: 20)
//        productImageView?.layer.shadowOpacity = 0.3
//        productImageView?.layer.shadowRadius = 6            initializeItems(visibility: false)

        }
    }
    
//    func configureWithProduct2(_ productDict: NSDictionary) {
//        // Setup the cell with information provided in productDict.
//        productNameLabel?.text = productDict.value(forKey: "title") as? String
//        
//        productPriceLabel?.text = productDict.value(forKeyPath: "price.data.formatted.with_tax") as? String
//        
//        var imageUrl = ""
//        
//        
//        if let images = productDict.value(forKey: "images") as? NSArray {
//            if (images.firstObject != nil) {
//                let obj = images.firstObject as? NSDictionary
//                if let urlKey = obj?.value(forKeyPath: "url.https") {
//                    imageUrl = urlKey as! String
//                }
//                
//            }
//        }
//        
////    
//      //  productImageView?.layer.borderWidth = 0.25
//        productImageView?.layer.masksToBounds = false
//        productImageView?.layer.borderColor = UIColor.lightGray.cgColor
//    //    productImageView?.layer.cornerRadius = 150.0
//        productImageView?.clipsToBounds = true
//        productImageView?.sizeToFit()
////        
////        productImageView?.layer.masksToBounds = false
////        productImageView?.layer.borderWidth = 1.0
////        productImageView?.clipsToBounds = true
////        productImageView?.layer.cornerRadius = 0
//     //   productImageView?.layer.borderColor = UIColor.lightGray.cgColor
//        
//        
//        productImageView?.layer.shadowOffset = CGSize(width: 10, height: 20)
//        productImageView?.layer.shadowOpacity = 0.3
//        productImageView?.layer.shadowRadius = 6
//        
//        
//        productImageView?.sd_setImage(with: URL(string: imageUrl))
//
//        
//
//    }
    
//    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//        super.apply(layoutAttributes)
//        if let attributes = layoutAttributes as? YSCollectionLayoutAttributes {
//            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
//        }
//    }
    

