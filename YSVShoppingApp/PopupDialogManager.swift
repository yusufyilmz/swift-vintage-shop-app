//
//  PopupDialog.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/28/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit
import PopupDialog

protocol YSCollectionPopupDialogDelegate {
    
    func sortProductsDelegate()
    
}



class PopupDialogManager {

    var delegate: YSCollectionPopupDialogDelegate!

    
    
    func getFilterDialogBox()-> PopupDialog  {
        // Create a custom view controller
        let sortVC = YSSortViewController(nibName: "SortViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: sortVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = DefaultButton(title: "Fiyata Göre Artan") {
            // self.label.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Fiyata Göre Azalan") {
            // self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        //  present(popup, animated: true, completion: nil)
        return popup
    }
    
    
    
    func getSortDialogBox()-> PopupDialog  {
        
        // Create a custom view controller
        let sortVC = YSSortViewController(nibName: "SortViewController", bundle: nil)
        
        // Create the dialog
        let popup = PopupDialog(viewController: sortVC, buttonAlignment: .vertical, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = DefaultButton(title: "Fiyata Göre Artan") {
            // self.label.text = "You canceled the rating dialog"
            self.delegate.sortProductsDelegate()
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Fiyata Göre Azalan") {
            // self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        //  present(popup, animated: true, completion: nil)
        return popup
        
    }
    
    func showImageDialog() -> PopupDialog {
        
        // Prepare the popup assets
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the popup dialog default view"
        let image = UIImage(named: "pexels-photo-103290")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
           // self.label.text = "You canceled the car dialog."
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "ADMIRE CAR") {
        //    self.label.text = "What a beauty!"
        }
        
        // Create third button
        let buttonThree = DefaultButton(title: "BUY CAR") {
          //  self.label.text = "Ah, maybe next time :)"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        return popup
        // Present dialog
        //self.present(popup, animated: true, completion: nil)
    }
    
    /*!
     Displays the standard dialog without image, just as the system dialog
     */
    func showStandardDialog() -> PopupDialog {
        
        // Prepare the popup
        let title = "THIS IS A DIALOG WITHOUT IMAGE"
        let message = "If you don't pass an image to the default dialog, it will display just as a regular dialog. Moreover, this features the zoom transition"
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, gestureDismissal: true) {
            print("Completed")
        }
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL") {
           // self.label.text = "You canceled the default dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "OK") {
         //   self.label.text = "You ok'd the default dialog"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
       // self.present(popup, animated: true, completion: nil)
        return popup

    }
    
    /*!
     Displays a custom view controller instead of the default view.
     Buttons can be still added, if needed
     */
//    func showCustomDialog()-> PopupDialog  {
//        
//        // Create a custom view controller
//        let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
//        
//        // Create the dialog
//        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
//        
//        // Create first button
//        let buttonOne = CancelButton(title: "CANCEL") {
//           // self.label.text = "You canceled the rating dialog"
//        }
//        
//        // Create second button
//        let buttonTwo = DefaultButton(title: "RATE") {
//           // self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
//        }
//        
//        // Add buttons to dialog
//        popup.addButtons([buttonOne, buttonTwo])
//        
//        // Present dialog
//      //  present(popup, animated: true, completion: nil)
//        return popup
//
//    }

}



