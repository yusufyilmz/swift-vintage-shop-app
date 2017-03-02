////
////  YSSearchViewController.swift
////  ShoppingApp
////
////  Created by yusuf yilmaz on 12/3/16.
////  Copyright © 2016 yusuf yilmaz. All rights reserved.
////
//
//import UIKit
//import SwiftSpinner
//
//class YSSearchViewController2: UITableViewController, CollectionModelProtocol, BrandModelProtocol, MainCollectionModelProtocol, ApiModelProtocol {
//    
//    let searchController = UISearchController(searchResultsController: nil)
//    
//    let model = generateRandomData()
//
//    @IBAction func cellHeaderButtonPressed(_ sender: AnyObject){
//        
//        if sender.tag == ItemType.Collection.rawValue {
//            performSegue(withIdentifier: SEARCH_COLLECTION_CELL_SEGUE, sender: self)
//            
//        }
//        else if sender.tag == ItemType.Brand.rawValue {
//            performSegue(withIdentifier: SEARCH_BRAND_CELL_SEGUE, sender: self)
//        }
//        
//    }
//    
//    
//    fileprivate let SEARCH_CELL_REUSE_IDENTIFIER = "SearchCellIdentifier"
//    
//    fileprivate let SEARCH_COLLECTION_CELL_SEGUE = "searchCollectionSegue"
//    
//    fileprivate let SEARCH_BRAND_CELL_SEGUE = "searchBrandSegue"
//    
//    fileprivate let SEARCH_PRODUCTS_CELL_SEGUE = "searchProductsListSegue2"
//    
//    fileprivate var selectedCollectionId:Int = -1
//    fileprivate var selectedBrandId:Int = -1
//    
//    var storedOffsets = [Int: CGFloat]()
//    
//    //  var searchList = Dictionary<String, NSMutableArray>()
//    fileprivate var searchList = SearchList()
//    fileprivate var searchListOk:Bool = false
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        
//        
//        
//        // Setup the Search Controller
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
//        definesPresentationContext = true
//        searchController.dimsBackgroundDuringPresentation = false
//        
//        // Setup the Scope Bar
//        searchController.searchBar.scopeButtonTitles = ["Hepsi", "Kategoriler", "Markalr", "Ürünler"]
//        tableView.tableHeaderView = searchController.searchBar
//        //tableView.isScrollEnabled = true
//        SwiftSpinner.show("Yükleniyor")
//        
//        let model = ApiModel()
//        model.collectionDelegate = self
//        model.brandDelegate = self
//        model.maincollectionDelegate = self
//        model.apiItemDelegate = self
//        
//        model.getAllMainHeads()
//        
//        model.getAllCollections()
//        model.getAllMainCollections()
//        model.getAllBrands()
//    }
//    
//    
//    func maincollectionsDownloaded(items: [MainCollectionModel]) {
//        
//        searchList.mainCollections = items
//        
//        if searchList.brands.count > 0 && searchList.collections.count > 0 {
//            SwiftSpinner.hide()
//            self.tableView.reloadData()
//        }
//        
//    }
//    
//    func itemsDownloaded(items: [StoreModel], itemType: ItemType) {
//        
//        if itemType == ItemType.MainHead {
//            searchList.mainHeads = items as! [MainHeadModel]
//            
//            if searchList.brands.count > 0 && searchList.mainCollections.count > 0 {
//                SwiftSpinner.hide()
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
//    
//    
//    func collectionsDownloaded(items: [CollectionModel]) {
//        
//        searchList.collections = items
//        
//        if searchList.brands.count > 0 && searchList.mainCollections.count > 0 {
//            SwiftSpinner.hide()
//            self.tableView.reloadData()
//        }
//    }
//    
//    func brandsDownloaded(items: [BrandModel]) {
//        searchList.brands = items
//        
//        if searchList.collections.count > 0 && searchList.mainCollections.count > 0 {
//            SwiftSpinner.hide()
//            self.tableView.reloadData()
//            
//        }
//    }
//    
//    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        
//        if indexPath.row == 0 {
//            //            let cell2 = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewCell", for: indexPath)
//            //
//            //            cell2.tag = ItemType.MainHead.rawValue
//            //            return cell2
//            //
//            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewCell", for: indexPath) as! YSSearchTableViewCell
//            
//            cell.tag = ItemType.MainHead.rawValue
//            return cell
//            
//            
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewWithCollectionViewCell", for: indexPath)
//            
//            cell.tag = ItemType.MainCollection.rawValue
//            return cell
//            
//        }
//        else if indexPath.row == 2 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewWithCollectionViewCell", for: indexPath)
//            
//            cell.tag = ItemType.Collection.rawValue
//            return cell
//            
//        }
//        else if indexPath.row == 3 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "YSSearchTableViewWithCollectionViewCell", for: indexPath)
//            
//            cell.tag = ItemType.Brand.rawValue
//            return cell
//            
//            
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewExtendedCell", for: indexPath)
//            cell.tag = 5
//
//            return cell
//        }
//        
//    }
//    
////    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
////    {
////        if indexPath.row == 0 {
////            
////            return 250
////            
////        }
////        else if indexPath.row == 1 {
////            
////            let mod = searchList.mainCollections.count % 2
////            if(mod == 0){
////                return CGFloat(searchList.mainCollections.count) / 2 * 100 + 50
////                
////            }else {
////                return CGFloat(searchList.mainCollections.count+1) / 2 * 100 + 50
////                
////            }
////            
////        }
////        else if indexPath.row == 2 {
////            
////            let mod = searchList.collections.count % 2
////            if(mod == 0){
////                return CGFloat(searchList.collections.count) / 2 * 100 + 50
////                
////            }else {
////                return CGFloat(searchList.collections.count+1) / 2 * 100 + 50
////                
////            }
////            
////        } else {
////            let mod = searchList.brands.count % 2
////            
////            if(mod == 0){
////                return CGFloat(searchList.brands.count) / 2 * 100 + 50
////                
////            }else {
////                return CGFloat(searchList.brands.count+1) / 2 * 100 + 50
////                
////            }
////            
////        }
////    }
////    
//    
//    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        
//        
//        if indexPath.row == 0 {
//            
//            guard let tableViewCell = cell as? YSSearchTableViewCell else { return }
//            
//            tableViewCell.setProperties(header: "Ana", buttonTag: ItemType.MainHead.rawValue)
//            
//            tableViewCell.setTableProperties(modelList: self.searchList.mainHeads)
//            
//        }
//        else {
//            
//         
//            
//            if indexPath.row == 1 {
//                   guard let tableViewCell = cell as? YSSearchTableViewWithCollectionViewCell else { return }
//                
//                tableViewCell.setProperties(header: "Kategoriler", buttonTag: ItemType.MainCollection.rawValue)
//                tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//                tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//            }
//            else if indexPath.row == 2 {
//                   guard let tableViewCell = cell as? YSSearchTableViewWithCollectionViewCell else { return }
//                tableViewCell.setProperties(header: "Alt Kategoriler", buttonTag: ItemType.Collection.rawValue)
//                tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//                tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//            } else if indexPath.row == 3 {
//                   guard let tableViewCell = cell as? YSSearchTableViewWithCollectionViewCell else { return }
//                tableViewCell.setProperties(header: "Markalar", buttonTag: ItemType.Brand.rawValue)
//                tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//                tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//            }
//            else {
//                
//           }
//            
//
//        }
//        
//        
//        
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        
//        
//        if indexPath.row == 0 {
//            
//            return
//        }
//        else {
//            
//            guard let tableViewCell = cell as? YSSearchTableViewWithCollectionViewCell else { return }
//            
//            storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
//        }
//        
//        
//        
//       
//    }
//    
//    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        //        filteredCandies = candies.filter({( candy : Candy) -> Bool in
//        //            let categoryMatch = (scope == "All") || (candy.category == scope)
//        //            return categoryMatch && candy.name.lowercased().contains(searchText.lowercased())
//        //        })
//        tableView.reloadData()
//    }
//    
//    
//}
//
//extension YSSearchViewController2: UISearchBarDelegate {
//    // MARK: - UISearchBar Delegate
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
//    }
//}
//
//extension YSSearchViewController2: UISearchResultsUpdating {
//    // MARK: - UISearchResultsUpdating Delegate
//    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
//    }
//}
//
//
//
//
//
//
//extension YSSearchViewController2: UICollectionViewDelegate, UICollectionViewDataSource {
//    
////    
////    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
////        
////        let CellCount = 2
////        let CellSpacing = 50
////        let CellWidth = 200
////        let collectionViewWidth = self.view.frame.maxX
////
////        
////        let totalCellWidth = CellWidth * CellCount
////        let totalSpacingWidth = CellSpacing * (CellCount - 1)
////        
////        let leftInset = (collectionViewWidth - CGFloat(totalCellWidth + totalSpacingWidth)) / 2;
////        let rightInset = leftInset
////        
////        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
////    }
//    
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        if collectionView.tag == 0 {
//            
//            
//            
//            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchSliderCollectionViewCell", for: indexPath) as! YSSearchSliderCollectionViewCell
//            
//            
//            cell.setCollectionProperties(model: self.searchList.mainHeads[indexPath.item])
//            
//            //cell.setCollectionProperties(model: self.searchList.mainHeads[indexPath.item])
//            return cell
//        }
//        else
//        {
//        
//            
//            if collectionView.tag == 1 {
//                
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchCollectionViewCell
//                
//                cell.setCollectionProperties(model: self.searchList.mainCollections[indexPath.item])
//                return cell
//
//            }
//            else if collectionView.tag == 2 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchCollectionViewCell
//                
//                cell.setCollectionProperties(model: self.searchList.collections[indexPath.item])
//                return cell
//
//                
//            }
//            else if collectionView.tag == 3 {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YSSearchCollectionViewCell", for: indexPath) as! YSSearchCollectionViewCell
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
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//        if collectionView.tag == 0 {
//            return (self.searchList.mainHeads.count)
//        }
//        else if collectionView.tag == 1 {
//            return (self.searchList.mainCollections.count)
//        }
//        else if collectionView.tag == 2 {
//            return (self.searchList.collections.count)
//        }
//        else if collectionView.tag == 3 {
//            return (self.searchList.brands.count)
//        }
//        else {
//            return model[collectionView.tag].count
//
//        }
//        
//        
//
//    }
//    
//    
//    
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        
//        let cell = collectionView.cellForItem(at: indexPath) as! YSSearchCollectionViewCell
//        
//        
//        if collectionView.tag == 0 {
//            
//            selectedCollectionId = (cell.productNameLabel?.tag)!
//            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
//            
//            
//        }
//        else if collectionView.tag == 1 {
//            
//            selectedCollectionId = (cell.productNameLabel?.tag)!
//            //  performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
//            //todo
//            
//        }
//        else if collectionView.tag == 2 {
//            
//            selectedCollectionId = (cell.productNameLabel?.tag)!
//            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
//            
//            
//        }
//        else if collectionView.tag == 3 {
//            
//            selectedBrandId = (cell.productNameLabel?.tag)!
//            performSegue(withIdentifier: SEARCH_PRODUCTS_CELL_SEGUE, sender: self)
//            
//        }
//        
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
//}
//
//
//
