//
//  YSSearchTableViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/20/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit
import SwiftSpinner

class YSSearchViewController: UITableViewController, ApiModelProtocol {
    
    let model = generateRandomData()
    var storedOffsets = [Int: CGFloat]()
    let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate var selectedCollectionId:Int = -1
    fileprivate var selectedBrandId:Int = -1
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    
    
    
    //  var searchList = Dictionary<String, NSMutableArray>()
    //fileprivate var searchList = SearchList()
    fileprivate var searchListOk:Bool = false
    
    
    fileprivate var searchModelList = [SearchModel](repeating: SearchModel(), count: 4)
    
    fileprivate let SEARCH_CELL_REUSE_IDENTIFIER = "SearchCellIdentifier"
    
    fileprivate let SEARCH_COLLECTION_CELL_SEGUE = "searchCollectionSegue"
    
    fileprivate let SEARCH_BRAND_CELL_SEGUE = "searchBrandSegue"
    
    fileprivate let SEARCH_PRODUCTS_CELL_SEGUE = "searchProductsListSegue2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        SwiftSpinner.show("Yükleniyor...")
        tableView.allowsSelection = false
        //
        tableView.isScrollEnabled = true
        let model = ApiModel()
        model.apiItemDelegate = self
        model.getAllCollections()
        model.getAllBrands()
        model.getAllMainHeads()
        model.getAllMainCollections()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func itemsDownloaded(items: [StoreModel], itemType: SearchItemType) {
        
        let model = SearchModel()
        model.CellPadding = 6.0
        
        if itemType == SearchItemType.MainHead {
            model.ColumnCount = 2
            model.RowCount = 1
            model.ItemName = ""
            model.CellHeight = 300.0
            model.CellNameHeight = 30.0
        }
        
        if itemType == SearchItemType.MainCollection {
            model.ColumnCount = 2
            model.RowCount = 2
            model.ItemName = "Kategoriler"
            model.CellHeight = 200.0
            model.CellNameHeight = 30.0
            
            
        }
        
        if itemType == SearchItemType.Collection {
            model.ColumnCount = 2
            model.RowCount = 1
            model.ItemName = "Alt Kategoriler"
            model.CellHeight = 200.0
            model.CellNameHeight = 30.0
            
        }
        
        if itemType == SearchItemType.Brand {
            model.ColumnCount = 3
            model.RowCount = 1
            model.ItemName = "Markalar"
            model.CellHeight = 150.0
            model.CellNameHeight = 30.0
            model.ItemNameVisibility = false
            
        }
        
        model.items = items
        model.ItemType = itemType
        searchModelList[itemType.rawValue] = model
        
        for item in searchModelList {
            if item.ItemType == SearchItemType.None {
                return
            }
        }
        
        tableView.reloadData()
        SwiftSpinner.hide()
        
        // SwiftSpinner.hide()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchModelList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        
        for item in searchModelList {
            if item.ItemType.rawValue == indexPath.row {
                
                return CGFloat(item.RowCount) * item.CellHeight + CGFloat(item.RowCount) * item.CellPadding  + item.CellNameHeight
                
            }
        }
        
        return 0
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            //            let cell2 = tableView.dequeueReusableCell(withIdentifier:
            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewMainCell", for: indexPath)
            cell.tag = (searchModelList[indexPath.row].ItemType.rawValue)
            
            return cell
            
            
        }
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewCell", for: indexPath)
            cell.tag = (searchModelList[indexPath.row].ItemType.rawValue)
            return cell
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let item = searchModelList[indexPath.row]
        
        if indexPath.row == 0 {
            
            guard let tableViewCell = cell as? YSSearchTableViewMainCell else { return }
            
            tableViewCell.setProperties(header: item.ItemName, buttonTag: item.ItemType.rawValue)
            
            tableViewCell.setTableProperties(modelList: item.items)
            
        } else {
            
            guard let tableViewCell = cell as? YSSearchTableViewCell else { return }
            tableViewCell.setProperties(header: item.ItemName, buttonTag: item.ItemType.rawValue)
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        }
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            return
        }
        
        guard let tableViewCell = cell as? YSSearchTableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
        
    }
    
    
}


extension YSSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        for item in searchModelList {
            
            if collectionView.tag == item.ItemType.rawValue {
                return item.items.count
            }
        }
        
        return 0
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //
    //
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchTableViewCollectionViewCell", for: indexPath) as! YSSearchTableViewCollectionViewCell
    //
    //
    //        for item in searchModelList {
    //
    //            if collectionView.tag == item.itemType.rawValue {
    //                cell.setCollectionProperties(model: item.items[indexPath.item])
    //            }
    //        }
    //
    //        return cell
    //
    //    }
    //
    //
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchTableViewCollectionViewCell", for: indexPath) as! YSSearchTableViewCollectionViewCell
        
        for item in searchModelList {
            
            if collectionView.tag == item.ItemType.rawValue {
                
                
                cell.setCollectionProperties(model: item.items[indexPath.row] , visibility: item.ItemNameVisibility)
            }
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}


extension YSSearchViewController: YSSearchCollectionViewLayoutDelegate {
    
    
    //
    //    func collectionView(_ collectionView:UICollectionView, heightForCellAtIndexPath indexPath:IndexPath , withWidth:CGFloat) -> CGFloat {
    //
    //        for item in searchModelList {
    //
    //            if collectionView.tag == item.itemType.rawValue {
    //
    //                return item.CellHeight
    //            }
    //        }
    //
    //        return 150.0
    //
    //    }
    
    // 2. Method to ask the delegate for the height of the annotation text
    
    
    func collectionViewCellProperties(collectionView:UICollectionView) -> [String: Any] {
        
        
        let padding : CGFloat = 0.0
        let height : CGFloat = 0.0
        
        var rowColumnCount:[String:Any] = ["row":0, "column":0, "height":height, "padding":padding]
        
        
        for item in searchModelList {
            
            if collectionView.tag == item.ItemType.rawValue {
                
                rowColumnCount["column"] = item.ColumnCount
                rowColumnCount["row"] = item.RowCount
                rowColumnCount["height"] = item.CellHeight
                rowColumnCount["padding"] = item.CellPadding
            }
        }
        
        
        //  rowColumnCount["column"] = (self.searchList.mainCollections.count)/rowCount
        return rowColumnCount
        
    }
    
    
}



////    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        //2
////        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
////        let availableWidth = view.frame.width - paddingSpace
////        let widthPerItem = availableWidth / itemsPerRow
////
////        return CGSize(width: widthPerItem, height: widthPerItem)
////    }
////
////    //3
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        insetForSectionAt section: Int) -> UIEdgeInsets {
////        return sectionInsets
////    }
////
////    // 4
////    func collectionView(_ collectionView: UICollectionView,
////                        layout collectionViewLayout: UICollectionViewLayout,
////                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
////        return sectionInsets.left
////    }
//
//
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//
////
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
////
////        if(searchList != nil && searchList.brands.count > 0) {
////            cell.setCollectionProperties(model: self.searchList.brands[indexPath.item])
////
////        }
////
////
////       // cell.backgroundColor = model[collectionView.tag][indexPath.item]
////
////        return cell
////
////
////
//        if collectionView.tag == 0 {
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
//
//            cell.setCollectionProperties(model: self.searchList.mainCollections[indexPath.item])
//            return cell
//        }
//        else if collectionView.tag == 0 {
//
//
//
////
////            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchSliderCollectionViewCell
////
////
////            cell.setCollectionProperties(model: self.searchList.mainHeads[indexPath.item])
////
////            //cell.setCollectionProperties(model: self.searchList.mainHeads[indexPath.item])
////            return cell
////
//
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
//
//            cell.setCollectionProperties(model: self.searchList.mainHeads[indexPath.item])
//            return cell
//        }
//        else
//        {
//
//
//            if collectionView.tag == 1 {
//
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
//
//                cell.setCollectionProperties(model: self.searchList.mainCollections[indexPath.item])
//                return cell
//
//            }
//            else if collectionView.tag == 2 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
//
//                cell.setCollectionProperties(model: self.searchList.collections[indexPath.item])
//                return cell
//
//
//            }
//            else if collectionView.tag == 3 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchExtendedCollectionViewCell
//
//                cell.setCollectionProperties(model: self.searchList.brands[indexPath.item])
//
//                return cell
//
//            }
//            else {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionExtendedViewCell", for: indexPath)
//
//                cell.backgroundColor = model[collectionView.tag][indexPath.item]
//
//                return cell
//            }
//
//        }
//
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
////        let cell = collectionView.cellForItem(at: indexPath) as! YSSearchCollectionViewCell
////
////
////        if collectionView.tag == 0 {
////
////            selectedCollectionId = (cell.productNameLabel?.tag)!
////            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
////
////
////        }
////        else if collectionView.tag == 1 {
////
////            selectedCollectionId = (cell.productNameLabel?.tag)!
////            //  performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
////            //todo
////
////        }
////        else if collectionView.tag == 2 {
////
////            selectedCollectionId = (cell.productNameLabel?.tag)!
////            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
////
////
////        }
////        else if collectionView.tag == 3 {
////
////            selectedBrandId = (cell.productNameLabel?.tag)!
////            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
////
////        }
////
//
//        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        if(segue.identifier == SEARCH_PRODUCTS_CELL_SEGUE) {
//            let newViewController = segue.destination as! YSProductListCollectionViewController
//
//            if selectedCollectionId != -1 {
//                newViewController.collectionId = String(selectedCollectionId)
//
//            }
//            else if selectedBrandId != -1 {
//                newViewController.brandId = String(selectedBrandId)
//            }
//
//        }
//
//        if segue.identifier == SEARCH_BRAND_CELL_SEGUE {
//            // Set up products list view!
//            let newViewController = segue.destination as! YSBrandViewController
//
//        }
//
//        if segue.identifier == SEARCH_COLLECTION_CELL_SEGUE {
//            // Set up products list view!
//            let newViewController = segue.destination as! YSCollectionsViewController
//
//        }
//    }
//
//}



/*
 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
 
 // Configure the cell...
 
 return cell
 }
 */

/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

