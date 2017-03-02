//
//  YSPopupViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/31/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSPopupViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
  
    @IBOutlet weak var checkBoxImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    

        // Configure the view for the selected state
    }
    
    
    func changeChecked() {
        isChecked = !isChecked
    }
    
    func initialize(title : String)
    {
        leftLabel.text = title
        isChecked = false
    }
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                checkBoxImage.image = UIImage(named: "CheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            } else {
                checkBoxImage.image = UIImage(named: "UncheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            }
        }
    }

    

}

