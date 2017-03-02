//
//  YSFilterPopupTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/30/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterLabel:UILabel?
    @IBOutlet weak var filterDetailLabel:UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(row: Int) {
        
        switch row {
        case 0:
            filterLabel?.text = FilterCategories.Collection.rawValue
            filterDetailLabel?.text = FilterCategories.Collection.rawValue
            break
        case 1:
            filterLabel?.text = FilterCategories.SubCollection.rawValue
            filterDetailLabel?.text = FilterCategories.SubCollection.rawValue
            break
        case 2:
            filterLabel?.text = FilterCategories.Brand.rawValue
            filterDetailLabel?.text = FilterCategories.Brand.rawValue
            break
        case 3:
            filterLabel?.text = FilterCategories.Price.rawValue
            filterDetailLabel?.text = FilterCategories.Price.rawValue
            break
        default:
            filterLabel?.text = FilterCategories.Collection.rawValue
            filterDetailLabel?.text = FilterCategories.Collection.rawValue
            break
        }
        
    }
    
    
 
    
    func configureCell(category: FilterCategories) {
        filterLabel?.text = category.rawValue
        filterDetailLabel?.text = category.rawValue

    }

}
