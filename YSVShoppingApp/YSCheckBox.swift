//
//  YSCheckBox.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/31/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit



class YSCheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "CheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    let uncheckedImage = UIImage(named: "UncheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        self.isOpaque = false
        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
        self.setImage(uncheckedImage, for: .normal)
        
    }
    
    override func awakeFromNib() {
//        self.addTarget(self, action: #selector(buttonClicked), for: UIControlEvents.touchUpInside)
//        self.setImage(uncheckedImage, for: .normal)
    }
    
    func changeChecked() {
        self.setImage(checkedImage, for: .normal)
    }
    
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
