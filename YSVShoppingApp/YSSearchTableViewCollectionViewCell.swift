//
//  YSSearchTableViewCollectionViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/20/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchTableViewCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var captionLabel: UILabel!
    //@IBOutlet fileprivate weak var commentLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addViews()
    }
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init—>Not being called???\n")
      //  self.label.adjustsFontSizeToFitWidth = true
       // self.cell.label.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
       // self.label.adjustsFontSizeToFitWidth = true
       // self.label.minimumScaleFactor = 0.8 //set the scale factor or minimumFontSize so that it can then start adjusting the font size.
       // Self.label.numberOfLines = 1
    }

 
 
    
    func addViews(){
    
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        
        blurView.frame = (captionLabel?.bounds)!
        //productNameLabel?.addSubview(blurView)
        captionLabel?.sendSubview(toBack: blurView)
        //captionLabel?.font = UIFont (name: "HelveticaNeue-Bold", size: 20)
        
        
        // productButton.tag = model.ID!
        
        
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        captionLabel.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 20)
        captionLabel.textAlignment = .center
        captionLabel.textColor = UIColor.white
        captionLabel?.center = self.center
        
        
                imageView?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
                //imageView?.contentMode = UIViewContentMode.scaleAspectFit
                imageView?.contentMode = .scaleToFill
        
                imageView?.layer.shadowOffset = CGSize(width: 10, height: 20)
                imageView?.layer.shadowOpacity = 0.3
                imageView?.layer.shadowRadius = 6
                imageView?.clipsToBounds = true
                imageView?.center = self.center
    }
    
    
    


    
//    var photo: Photo? {
//        didSet {
//            if let photo = photo {
//                imageView.image = photo.image
//                captionLabel.text = photo.caption
//                commentLabel.text = photo.comment
//            }
//        }
//    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? YSSearchCollectionViewLayoutAttributes {
            imageViewHeightLayoutConstraint.constant = attributes.photoHeight
        }
    }
    
    
    
    // @IBOutlet fileprivate weak var cellName: UILabel!
    
    
    func setText(text: String)  {
        // productNameLabel?.text = text
    }
    
    func setImage()  {
        
        let image = UIImage(named: "search")
        imageView?.image = image
    }
    


    
    func setCollectionProperties(model: StoreModel, visibility: Bool)  {
        
        

//        
//        
//        imageView?.autoresizingMask = [.flexibleHeight, .flexibleWidth, .flexibleBottomMargin, .flexibleTopMargin]
//        //imageView?.contentMode = UIViewContentMode.scaleAspectFit
//        imageView?.contentMode = .scaleToFill
//
//        imageView?.layer.shadowOffset = CGSize(width: 10, height: 20)
//        imageView?.layer.shadowOpacity = 0.3
//        imageView?.layer.shadowRadius = 6
//        imageView?.clipsToBounds = true
//        imageView?.center = self.center

        
        let image : UIImage = UIImage(data: model.ImageContent as! Data)!
        imageView?.image = image
        captionLabel?.tag = model.ID!

        if visibility == true {
            captionLabel?.text = model.Title
        }
        else {
            captionLabel?.text = ""

        }
        
        



        
    }

    
}
