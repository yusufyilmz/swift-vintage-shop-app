//
//  YSSearchTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/19/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchTableViewWithCollectionViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    @IBOutlet fileprivate weak var cellName: UILabel!

    @IBOutlet fileprivate weak var cellButton: UIButton!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

extension YSSearchTableViewWithCollectionViewCell {
    
    
    func setProperties(header: String, buttonTag: Int) {
        cellName.text = header
        cellButton.tag = buttonTag

    }
    
    func setCollectionViewDataSourceDelegate
        <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>>
        (dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
   // collectionView.collectionViewLayout = layout
       
       /// let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        
        collectionView.reloadData()

    }




    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        
        get {
            return collectionView.contentOffset.x
        }
    }
}
