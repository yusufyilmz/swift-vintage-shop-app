//
//  YSBrandViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import SwiftSpinner

class YSBrandViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ApiModelProtocol {


    @IBOutlet weak var tableView:UITableView?
    
    fileprivate var Brands:[BrandModel]?
    
    fileprivate let BRAND_CELL_REUSE_IDENTIFIER = "BrandCellIdentifier"
    
    fileprivate let BRANDS_LIST_SEGUE_IDENTIFIER = "brandProductsListSegue"
    

    fileprivate var selectedBrand:BrandModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftSpinner.show("Yükleniyor")
        let storeModel = ApiModel()
        storeModel.apiItemDelegate = self
        storeModel.getAllBrands()
    }
    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType) {
        SwiftSpinner.hide()
        Brands = items as! [BrandModel]
        self.tableView?.reloadData()
    }

 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Data source & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.Brands != nil {
            return self.Brands!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BRAND_CELL_REUSE_IDENTIFIER, for: indexPath) as! YSBrandTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        cell.setBrand(brand: (self.Brands?[row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //selectedBrandDict = brands?.object(at: (indexPath as NSIndexPath).row) as? NSDictionary
        
        selectedBrand = self.Brands?[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: BRANDS_LIST_SEGUE_IDENTIFIER, sender: self)
        
        
    }
    
    func tableView(_ _tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
//        
//        if segue.identifier == BRANDS_LIST_SEGUE_IDENTIFIER {
//            // Set up products list view!
//            let newViewController = segue.destination as! YSProductListTableViewController
//            newViewController.title = selectedBrandDict!.value(forKey: "title") as? String
//            newViewController.brandId = selectedBrandDict!.value(forKeyPath: "id") as? String
//            
//        }
        
        if segue.identifier == BRANDS_LIST_SEGUE_IDENTIFIER {
            // Set up products list view!
            let newViewController = segue.destination as! YSProductListCollectionViewController
            newViewController.title = self.selectedBrand?.Title
          //  newViewController.brandId = self.selectedBrand?.Id
            
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
