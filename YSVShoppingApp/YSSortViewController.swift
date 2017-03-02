//
//  RatingViewController.swift
//  PopupDialog
//
//  Created by Martin Wildfeuer on 11.07.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class YSSortViewController: UIViewController {
    
    @IBOutlet weak var descendingPrice: UILabel!
    
    @IBOutlet weak var ascendingPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   ascendingPrice.delegate = self
//        descendingPrice.delegate = self

     
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endEditing() {
        view.endEditing(true)
    }
    
    func sortAscendingPrice() {
        view.endEditing(true)
    }
    
    func sortDescendingPrice() {
        view.endEditing(true)
    }
}



