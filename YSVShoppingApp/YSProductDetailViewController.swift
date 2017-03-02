//
//  YSProductDetailViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import SwiftSpinner

class YSProductDetailViewController: UIViewController {
    
    var product:ProductModel?
    
    @IBOutlet weak var descriptionTextView:UITextView?
    @IBOutlet weak var productImageView:UIImageView?
    @IBOutlet weak var buyButton:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyButton?.backgroundColor = YS_COLOR
        
        // Do any additional setup after loading the view.
        self.descriptionTextView?.text = product?.Description
            
    
        
        if let price = product?.Price {
            let buyButtonTitle = String(format: "Buy Now (%@)", price)
            self.buyButton?.setTitle(buyButtonTitle, for: UIControlState())
        } 
        
        let image : UIImage = UIImage(data: product!.ImageContent as! Data)!
        productImageView?.image = image

            
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buyProduct(_ sender: AnyObject) {
        // Add the current product to the cart
        //let productId:String = productDict!.object(forKey: "id") as! String

        SwiftSpinner.show("Yükleniyor")
        
//        Moltin.sharedInstance().cart.insertItem(withId: product?.ID, quantity: 1, andModifiersOrNil: nil, success: { (response) -> Void in
//            // Done.
//            // Switch to cart...
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.switchToCartTab()
//            
//            // and hide loading UI
//            SwiftSpinner.hide()
//            
//            
//        }) { (response, error) -> Void in
//            // Something went wrong.
//            // Hide loading UI and display an error to the user.
//            SwiftSpinner.hide()
//            
//            AlertDialog.showAlert("Error", message: "Couldn't add product to the cart", viewController: self)
//            print("Something went wrong...")
//            print(error)
//        }
//        
    }
    
    
    
}
