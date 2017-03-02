//
//  YSFilterPopupViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/30/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//
//
import UIKit
import SwiftSpinner
//import QuartzCore
//
//
enum FilterCategories : String  {
    case Collection = "Kategori"
    case SubCollection = "Alt Kategori"
    case Brand = "Marka"
    case Price = "Fiyat"
    static var count: Int { return FilterCategories.Price.hashValue + 1}

}


class YSFilterViewController : UITableViewController, ApiModelProtocol {

    fileprivate let FILTER_CELL_REUSE_IDENTIFIER = "YSFilterTableViewCell"
    
    var popViewController : YSPopupViewController!
    // MARK: - Table view data source
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 

    }
    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType) {
        let bundle = Bundle(for: YSPopupViewController.self)
        
        self.popViewController = YSPopupViewController(nibName: "YSPopupViewController", bundle: bundle)
        self.popViewController.collections = items as! [CollectionModel]
        self.popViewController.title = "This is a popup view"
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
        
        
        SwiftSpinner.hide()
    }
    
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        
        return FilterCategories.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> YSFilterTableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FILTER_CELL_REUSE_IDENTIFIER, for: indexPath) as! YSFilterTableViewCell
                
        cell.configureCell(row: (indexPath as NSIndexPath).row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = ApiModel()
        model.apiItemDelegate = self
        SwiftSpinner.show("Yükleniyor...")
        

    }
    
    override func tableView(_ _tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object tot the new view controller.
        
//        if segue.identifier == PRODUCT_DETAIL_VIEW_SEGUE_IDENTIFIER {
//            // Set up product detail view
//            let newViewController = segue.destination as! YSProductDetailViewController
//            
//            newViewController.title = selectedProductDict!.value(forKey: "title") as? String
//
//            
//            
//            //    newViewController.productDict = selectedProductDict
//            
//        }
    }
}
