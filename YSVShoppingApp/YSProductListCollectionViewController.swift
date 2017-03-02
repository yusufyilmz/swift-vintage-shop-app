//
//  YSProductListCollectionViewController2.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/21/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import AVFoundation
import PopupDialog
import SwiftSpinner

class YSProductListCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ApiModelProtocol {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var newProductButton:UIButton?
    @IBOutlet weak var allProductButton:UIButton?
    @IBOutlet weak var specialProductButton:UIButton?
    @IBOutlet weak var navigationBar:UINavigationBar?
    weak var underlineView: UIView!

    //var filterPopViewController : YSFilterViewController!
    fileprivate let SHOPPING_CART_VIEW_SEGUE_IDENTIFIER = "YSShoppingCartSegue"
    fileprivate let FILTER_DETAIL_VIEW_SEGUE_IDENTIFIER = "FilterTableViewSegue"

    fileprivate let LAYOUT_CELL_REUSE_IDENTIFIER = "YSProductCollectionViewCell"
    fileprivate let LOAD_MORE_CELL_IDENTIFIER = "ProductsLoadMoreCell"
    fileprivate let PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER = "productDetailSegue"
    fileprivate var selectedProduct:ProductModel?
    var collectionId:String? = nil
    var brandId:String? = nil
    var Products = [ProductModel]()
    var border = CALayer()
    
    

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storeModel = ApiModel()

        storeModel.apiItemDelegate = self
        
        SwiftSpinner.show("Yükleniyor")

        
        //addUnderline()
        if collectionId != nil {
            initializeItems(visibility: true)
            
            storeModel.getProductsWithCollectionId(id: collectionId!)
        }
        else if brandId != nil {
            initializeItems(visibility: true)
            storeModel.getProductsWithBrandId(id: collectionId!)

        }
        else {
            initializeItems(visibility: false)
            storeModel.getAllProducts()

        }
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        
       // addUnderline(button: newProductButton!)
     //   addUnderline(button: allProductButton!)

          //  self.collectionView?.isScrollEnabled = false

    }

    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType) {
        self.Products = (items as? [ProductModel])!
        self.collectionView.reloadData()
        
        SwiftSpinner.hide()
    }
    
    func initializeItems(visibility: Bool)  {
        
        let shoppingCartButton = UIBarButtonItem(image: UIImage(named: "shopping-cart")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(YSProductListCollectionViewController.showShoppingCartPage(_:)))
        self.navigationItem.rightBarButtonItem = shoppingCartButton
        
        
        newProductButton?.isHidden = visibility
        allProductButton?.isHidden = visibility
        specialProductButton?.isHidden = visibility
        navigationBar?.isHidden = !visibility
        
        //addUnderline()
        
        if visibility == true {
            
            let btn1 = UIButton(type: .custom)
            
            
            btn1.setImage(UIImage(named: "search")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
            btn1.setTitle("Filtrele", for: .normal)
            btn1.setTitleColor(UIColor.gray, for: .normal)
            btn1.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            btn1.tintColor = .black
            btn1.addTarget(self, action: #selector(YSProductListCollectionViewController.filterProducts(_:)), for: .touchUpInside)
            
            var insetAmount:CGFloat = 45
            btn1.imageEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
            btn1.titleEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
            //btn1.contentEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, insetAmount);
            
            
            let item1 = UIBarButtonItem(customView: btn1)
            
            let btn2 = UIButton(type: .custom)
            btn2.setImage(UIImage(named: "search"), for: .normal)
            btn2.setTitle("Sırala", for: .normal)
            btn2.setTitleColor(UIColor.gray, for: .normal)
            btn2.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
            btn2.addTarget(self, action: #selector(YSProductListCollectionViewController.sortProducts(_:)), for: .touchUpInside)
            insetAmount = 40.0
            
            btn2.imageEdgeInsets = UIEdgeInsetsMake(0, insetAmount, 0, -insetAmount);
            btn2.titleEdgeInsets = UIEdgeInsetsMake(0, -insetAmount, 0, insetAmount);
            let item2 = UIBarButtonItem(customView: btn2)
            self.navigationBar?.items?[0].setRightBarButtonItems([item1, item2], animated: true)
            
        
        }
        else {
            border = CALayer()
            let width = CGFloat(2.0)
            border.borderColor = UIColor.darkGray.cgColor
            //border.frame = CGRect(x: 0, y: tw.frame.size.height - width, width:  tw.frame.size.width, height: tw.frame.size.height)
            
            border.frame = CGRect(x: 0, y: newProductButton!.frame.size.height - width, width:  newProductButton!.frame.size.width, height: newProductButton!.frame.size.height)
            //
            border.borderWidth = width
            
            addUnderline(button: allProductButton!)
        }
        
        
   
        
        
    }
    
    func addUnderline(button : UIButton) {
     
        UIView.animate(withDuration: 3.0, animations:{
            
            self.border.removeFromSuperlayer()
            button.layer.addSublayer(self.border)
            
            button.layer.masksToBounds = true

            
        })
        
        
        
        
    }

    
    
    
    @IBAction func showAllProducts(_ sender: AnyObject){
        
        //allProductButton?.setTitleColor(UIColor.brown, for: UIControlState.highlighted)
        addUnderline(button: allProductButton!)

//        ProductManager.sharedInstance.loadAllProducts(completion: { (products) in
//            self.Products = products
//            self.collectionView.reloadData()
//            
//        })
    }
    
    @IBAction func showNewProducts(_ sender: AnyObject){
     
      
        addUnderline(button: newProductButton!)
        //updateConstraintsForUnderlineView(underlineView, underButton: newProductButton!)
//        ProductManager.sharedInstance.loadNewProducts(completion: { (products) in
//            self.Products = products
//            self.collectionView.reloadData()
//            
//        })
        
    }
    
    @IBAction func showSpecialProducts(_ sender: AnyObject){
        
        addUnderline(button: specialProductButton!)

//        ProductManager.sharedInstance.loadNewProducts(completion: { (products) in
//            self.Products = products
//            self.collectionView.reloadData()
//            
//        })
    }
    

    
    
    
    func sortProducts(_ sender: UIBarButtonItem)  {
        
        //            // Prepare the popup
        //            let title = "THIS IS A DIALOG WITHOUT IMAGE"
        //            let message = "If you don't pass an image to the default dialog, it will display just as a regular dialog. Moreover, this features the zoom transition"
        //
        //
        //        PopupDialog(
        //            // Create the dialog
        //            let popup = PopupDialog(title: title, message: message, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true) {
        //                print("Completed")
        //            }
        //
        
        let sortVC = YSSortViewController(nibName: "YSSortViewController", bundle: nil)
        //
        //        // Create the dialog
        let popup = PopupDialog(viewController: sortVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonIncreasingPriceProduct = CancelButton(title: "Fiyata Göre Artan") {
            //self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        let buttonDecreasingPriceProduct = DefaultButton(title: "Fiyata Göre Azalan") {
            //  self.label.text = "You ok'd the default dialog"
        }
        
        let buttonNewProduct = DefaultButton(title: "En Yeniler") {
            //  self.label.text = "You ok'd the default dialog"
        }
        
        let buttonFavouriteProduct = DefaultButton(title: "Favorilerimiz") {
            //  self.label.text = "You ok'd the default dialog"
        }
        // Add buttons to dialog
        popup.addButtons([buttonIncreasingPriceProduct, buttonDecreasingPriceProduct, buttonNewProduct ,buttonFavouriteProduct])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    
    
    func filterProducts(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: FILTER_DETAIL_VIEW_SEGUE_IDENTIFIER, sender: self)

        //let bundle = Bundle(for: YSFilterViewController.self)
        
        
        
//        self.filterPopViewController = YSFilterViewController(nibName: "YSFilterViewController", bundle: bundle)
//        self.filterPopViewController.title = "This is a popup view"
//        self.filterPopViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
//        
        
        
        //        let sortVC = YSFilterViewController(nibName: "YSFilterViewController", bundle: nil)
        //
        //        // Create the dialog
        //        let popup = PopupDialog(viewController: sortVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        //
        //        // Create first button
        //        let buttonOne = DefaultButton(title: "Ürünleri Listele") {
        //            // self.label.text = "You canceled the rating dialog"
        //            self.Products.removeAll()
        //            self.collectionView.reloadData()
        //        }
        //
        //        // Create second button
        //        let buttonTwo = DefaultButton(title: "Seçimleri Temizle") {
        //            // self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        //        }
        //
        //        // Add buttons to dialog
        //        popup.addButtons([buttonOne, buttonTwo])
        //
        //        // Present dialog
        //        present(popup, animated: true, completion: nil)
    }
    
    func showShoppingCartPage (_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: SHOPPING_CART_VIEW_SEGUE_IDENTIFIER, sender: self)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Products.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let product:ProductModel = Products[(indexPath as NSIndexPath).row]
        
        selectedProduct = product
        performSegue(withIdentifier: PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER, sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object tot the new view controller.
        
        if segue.identifier == PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER {
            // Set up product detail view
            let newViewController = segue.destination as! YSProductDetailViewController
            
            newViewController.title = selectedProduct?.Title
            
            newViewController.product = selectedProduct
            
        }
        
        if segue.identifier == SHOPPING_CART_VIEW_SEGUE_IDENTIFIER {
            // Set up product detail view
            let newViewController = segue.destination as! YSCartViewController
            
            // newViewController.title = selectedProduct?.Title
            
        }
        
        
        if segue.identifier == FILTER_DETAIL_VIEW_SEGUE_IDENTIFIER {
            let newViewController = segue.destination as! YSFilterViewController

        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSProductCollectionViewCell", for: indexPath) as! YSProductCollectionViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        let product:ProductModel = Products[row]
        cell.favouriteProductButton?.tag = product.ID!
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 10
        
        
        //
        //        cell.layer.shadowOffset = CGSize(width:0, height:0)
        //        cell.layer.shadowColor = UIColor.blue.cgColor
        //        cell.layer.shadowRadius = 4
        //        cell.layer.shadowOpacity = 0.25
        //        cell.layer.masksToBounds = false;
        //        cell.clipsToBounds = false;
        
        cell.configureWithProduct(product: product)
        return cell
        
        
    }
    
    
    
    
    
}

