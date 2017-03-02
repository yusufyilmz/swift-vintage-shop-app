//
//  YSRoundedCornersView.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/20/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

@IBDesignable
class YSRoundedCornersView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
}

