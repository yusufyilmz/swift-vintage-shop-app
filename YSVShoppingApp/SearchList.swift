//
//  SearchList.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/3/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit


enum SearchItemType : Int {
    case MainHead = 0
    case MainCollection = 1
    case Collection = 2
    case Brand = 3
    case Product = 4
    case None = 5
    
}

enum SearchCellType : Int {
    case Normal = 0
    case Slide = 1
}

class SearchModel: NSObject {

    public var items:[StoreModel] = []
    
    var RowCount:Int = 0
    
    var ColumnCount:Int = 0
    
    var CellHeight:CGFloat = 0

    var CellPadding:CGFloat = 0
    
    var CellNameHeight:CGFloat = 0

    var ItemType:SearchItemType = SearchItemType.None
    
    var ItemName:String = ""
    
    var ItemNameVisibility:Bool = true

    var CellType:SearchCellType = SearchCellType.Normal

    
    override init()
    {
    
    }
}


class SearchList: NSObject {
    
    public var mainCollections:[MainCollectionModel] = []
    
    public var collections:[CollectionModel] = []
    
    public var brands:[BrandModel] = []
    
    public var mainHeads:[MainHeadModel] = []
    
    
}


