//
//  YSSearchTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/20/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchTableViewCell: UITableViewCell {

    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    
    @IBOutlet fileprivate weak var cellView: UIView!

    var cellName: UILabel!
    
    //@IBOutlet fileprivate weak var cellButton: UIButton!
    
    
    fileprivate var blurEffect:UIBlurEffect? = nil
    fileprivate var blurView:UIVisualEffectView? = nil
    
    
    func setCellBlurViews () {
        
        //Create the visual effect
        //You can choose between ExtraLight, Light and Dark
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .dark)
        
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
//        blurView.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
//        blurView.layer.borderWidth = 1.0
//        blurView.layer.cornerRadius = 6.0

        blurView.translatesAutoresizingMaskIntoConstraints = false
        //cellView.addSubview(blurView)
        blurView.frame = self.cellView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.cellView.addSubview(blurView) //
        
        
        
        
        //AutoLayout code
        //Size
        blurView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        blurView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        //Center
        cellView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .left, relatedBy: .equal, toItem: cellView, attribute: .left, multiplier: 1.0, constant: 0))
        
        cellView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .right, relatedBy: .equal, toItem: cellView, attribute: .right, multiplier: 1.0, constant: 0))
        
        cellView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .top, relatedBy: .equal, toItem: cellView, attribute: .top, multiplier: 1.0, constant: 0))
        
        cellView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .height, relatedBy: .equal, toItem: cellView, attribute: .height, multiplier: 1.0, constant: 0))
        
        
//        cellView.addConstraint(NSLayoutConstraint(item: blurView, attribute: .centerY, relatedBy: .equal, toItem: cellView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        let vibrancyView: UIVisualEffectView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        vibrancyView.translatesAutoresizingMaskIntoConstraints =  false
        blurView.contentView.addSubview(vibrancyView)
        //AutoLayout code
        //Size
   
        vibrancyView.addConstraint(NSLayoutConstraint(item: vibrancyView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 250))
        vibrancyView.addConstraint(NSLayoutConstraint(item: vibrancyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 400))
        //Center
        blurView.addConstraint(NSLayoutConstraint(item: vibrancyView, attribute: .centerX, relatedBy: .equal, toItem: blurView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        blurView.addConstraint(NSLayoutConstraint(item: vibrancyView, attribute: .centerY, relatedBy: .equal, toItem: blurView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        cellName = UILabel()
        cellName.translatesAutoresizingMaskIntoConstraints = false
        
        cellName.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        cellName.textAlignment = .center
        cellName.textColor = UIColor.white
        vibrancyView.contentView.addSubview(cellName)
        //AutoLayout code
        //Center
        vibrancyView.addConstraint(NSLayoutConstraint(item: cellName, attribute: .centerX, relatedBy: .equal, toItem: vibrancyView, attribute: .centerX, multiplier: 1.0, constant: 0))
        vibrancyView.addConstraint(NSLayoutConstraint(item: cellName, attribute: .centerY, relatedBy: .equal, toItem: vibrancyView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellBlurViews()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        blurEffect = UIBlurEffect(style: .dark)
        
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView?.translatesAutoresizingMaskIntoConstraints = false
        //self.label.addSubview(blurView!)
        // Configure the view for the selected state
    }
    
    func setProperties(header: String, buttonTag: Int) {
        cellName.text = header
    
        //cellButton.tag = buttonTag
        //blurView?.contentView.addSubview(cellName)

        //cellName?.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
        
     
   
    }
    
    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        let source = dataSourceDelegate as! YSSearchViewController
        
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        
        
        if let layout = collectionView?.collectionViewLayout as? YSSearchCollectionViewLayout
        {
            layout.delegate = source
        }
        
        collectionView!.backgroundColor = UIColor.clear
        //collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }

}
