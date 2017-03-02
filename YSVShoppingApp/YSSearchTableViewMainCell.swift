//
//  YSSearchTableViewCell.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/10/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//

import UIKit

class YSSearchTableViewMainCell: UITableViewCell {

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
        
      
        //2
        textView.textAlignment = .center
        textView.text = ""
        
        

    }
    
    func setProperties(header: String, buttonTag: Int) {
//        cellName.text = header
//        cellButton.tag = buttonTag
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setTableProperties(modelList: [StoreModel]) {
 

        self.scrollView.frame = CGRect(x:0, y:0, width:self.frame.width, height:self.frame.height)
        self.scrollView.contentInset.top = 0
        self.scrollView.contentInset.left = 0
        //
        //self.scrollView.center = self.center
        scrollViewWidth = self.scrollView.frame.width
        scrollViewHeight = self.scrollView.frame.height
        

        for model in modelList {

            let frameX = sliderCount * scrollViewWidth
            let imgView = UIImageView(frame: CGRect(x: frameX , y:0,width:scrollViewWidth, height:scrollViewHeight))
            
            sliderCount = sliderCount + 1
            
            let image : UIImage = UIImage(data: model.ImageContent as! Data)!
            imgView.image = image
            self.scrollView.addSubview(imgView)
        }
        
        
  
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * sliderCount, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        //
        
        
    }
    
    
    
    
    
    
}

//
extension YSSearchTableViewMainCell: UIScrollViewDelegate  {
    
    func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * sliderCount
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
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //self.startButton.alpha = 1.0
        })
    }
    
}

