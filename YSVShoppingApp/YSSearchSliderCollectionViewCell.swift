//
//  YSSearchSliderCollectionViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/9/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchSliderCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var productNameLabel:UILabel?
//    
//    @IBOutlet weak var collectionImage:UIImageView?
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet var textView: UITextView!
    
    @IBOutlet var pageControl: UIPageControl!
    
    var scrollViewWidth:CGFloat = 0
    
    var scrollViewHeight:CGFloat = 0
    
    var sliderCount:CGFloat = 0
    // @IBOutlet fileprivate weak var cellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.scrollView.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height)
        scrollViewWidth = self.scrollView.frame.width
        scrollViewHeight = self.scrollView.frame.height
        //2
        textView.textAlignment = .center
        textView.text = ""
        
        
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 4, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        //Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    
        
    }
    

    
    
    func setCollectionProperties(model: MainHeadModel) {
        
        let frameX = sliderCount * scrollViewWidth
        let imgView = UIImageView(frame: CGRect(x: frameX , y:0,width:scrollViewWidth, height:scrollViewHeight))
        
        sliderCount = sliderCount + 1
        
        let image : UIImage = UIImage(data: model.ImageContent as! Data)!
        imgView.image = image
        self.scrollView.addSubview(imgView)

    }

    


    
    
}


extension YSSearchSliderCollectionViewCell: UIScrollViewDelegate  {
    
    func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth{
            slideToX = 0
        }
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
    
    //MARK: UIScrollView Delegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = ""
        }else if Int(currentPage) == 1{
            textView.text = ""
        }else if Int(currentPage) == 2{
            textView.text = ""
        }else{
            textView.text = ""
            // Show the "Let's Start" button in the last slide (with a fade in animation)
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                //self.startButton.alpha = 1.0
            })
        }
    }
    
}
