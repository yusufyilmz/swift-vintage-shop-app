//
//  YSCollectionsViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/8/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import SwiftSpinner
class YSCollectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ApiModelProtocol {
    
    @IBOutlet weak var tableView:UITableView?
    
    fileprivate var collections:[CollectionModel]?
    
    fileprivate let COLLECTION_CELL_REUSE_IDENTIFIER = "CollectionCell"
    
    fileprivate let PRODUCTS_LIST_SEGUE_IDENTIFIER = "productsListSegue"
    
    fileprivate let COLLECTIONS_LIST_SEGUE_IDENTIFIER = "collectionProductsListSegue2"

    
    fileprivate var selectedCollection:CollectionModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Kategoriler"
        let screenSize: CGRect = UIScreen.main.bounds
        
        SwiftSpinner.show("Yükleniyor")
        let storeModel = ApiModel()
        storeModel.apiItemDelegate = self
        storeModel.getAllCollections()
   
    }
    
  
    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType) {
        SwiftSpinner.hide()
        collections = items as? [CollectionModel]
        self.tableView?.reloadData()
    }
    
    
    // MARK: - TableView Data source & Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collections != nil {
            return collections!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: COLLECTION_CELL_REUSE_IDENTIFIER, for: indexPath) as! YSCollectionTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
       // let collectionDictionary = collections?.object(at: row) as! NSDictionary

        cell.setCollection(collection : (collections?[row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
     //   selectedCollectionDict = collections?.object(at: (indexPath as NSIndexPath).row) as? NSDictionary
        
        selectedCollection = collections?[(indexPath as NSIndexPath).row]
        
        
        performSegue(withIdentifier: COLLECTIONS_LIST_SEGUE_IDENTIFIER, sender: self)
        
        
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        
        
        
        
        if segue.identifier == COLLECTIONS_LIST_SEGUE_IDENTIFIER {
            // Set up products list view!
            let newViewController = segue.destination as! YSProductListCollectionViewController
            
            
            
            newViewController.title = selectedCollection?.Title
            newViewController.collectionId = selectedCollection?.Slug
//
            
//            newViewController.title = selectedCollectionDict!.value(forKey: "title") as? String
//            newViewController.collectionId = selectedCollectionDict!.value(forKeyPath: "id") as? String
            
        }
        
   
        
//        if segue.identifier == PRODUCTS_LIST_SEGUE_IDENTIFIER {
//            // Set up products list view!
//            let newViewController = segue.destination as! YSProductListTableViewController2
//            
//            newViewController.title = selectedCollectionDict!.value(forKey: "title") as? String
//            newViewController.collectionId = selectedCollectionDict!.value(forKeyPath: "id") as? String
//            
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

