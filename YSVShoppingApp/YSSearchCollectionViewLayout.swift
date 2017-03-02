//
//  YSSearchCollectionViewLayout.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 1/18/17.
//  Copyright © 2017 yusuf yilmaz. All rights reserved.
//



import UIKit
protocol YSSearchCollectionViewLayoutDelegate {
    // 1. Method to ask the delegate for the height of the image
    //func collectionView(_ collectionView:UICollectionView, heightForCellAtIndexPath indexPath:IndexPath , withWidth:CGFloat) -> CGFloat
    // 2. Method to ask the delegate for the height of the annotation text
 //   func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
    func collectionViewCellProperties(collectionView:UICollectionView) -> [String:Any]
    
}

class YSSearchCollectionViewLayoutAttributes:UICollectionViewLayoutAttributes {
    
    // 1. Custom attribute
    var photoHeight: CGFloat = 0.0
    
    // 2. Override copyWithZone to conform to NSCopying protocol
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! YSSearchCollectionViewLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    // 3. Override isEqual
    override func isEqual(_ object: Any?) -> Bool {
        if let attributtes = object as? YSSearchCollectionViewLayoutAttributes {
            if( attributtes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}


class YSSearchCollectionViewLayout: UICollectionViewLayout {
    //1. Pinterest Layout Delegate
    var delegate:YSSearchCollectionViewLayoutDelegate!
    
    
    fileprivate var cellPadding:CGFloat  = 0.0
    fileprivate var cellHeight: CGFloat = 0.0
    fileprivate var numberOfRows:Int  = 0
    fileprivate var numberOfColumns:Int  = 0
    fileprivate var contentHeight: CGFloat = 0.0
    fileprivate var contentWidth:CGFloat  = 0.0
    fileprivate var collectionViewWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    fileprivate var collectionViewHeight: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.height - (insets.top + insets.bottom)
        
    }
    
    fileprivate var cache = [YSSearchCollectionViewLayoutAttributes]()

    
    override class var layoutAttributesClass : AnyClass {
        return YSSearchCollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        

        // 1. Only calculate once
        if cache.isEmpty {
            
            if(delegate != nil) {
                
                let rowColumnCount = delegate.collectionViewCellProperties(collectionView: self.collectionView!)
                
                numberOfRows = rowColumnCount["row"]! as! Int
                numberOfColumns = rowColumnCount["column"]! as! Int
                cellPadding = rowColumnCount["padding"]! as! CGFloat
                cellHeight = rowColumnCount["height"]!as! CGFloat
                
                //index = rowColumnCount["index"]!
            }
            
            // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
            //let columnWidth = contentWidth / CGFloat(numberOfColumns)
            
            collectionView!.contentInset.top = cellPadding

            //let columnHeight = contentHeight / CGFloat(numberOfRows)
            let cellWidth:CGFloat = self.collectionViewWidth / CGFloat(numberOfColumns)
            
            
            var yOffset = [CGFloat]()
            for column in 0 ..< numberOfRows {
                yOffset.append(CGFloat(column) * cellHeight )
            }
            
            var row = 0
            var xOffset = [CGFloat](repeating: 0, count: numberOfRows)
            //var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            // 3. Iterates through the list of items in the first section
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
                //let width = columnWidth - cellPadding*2
                let height = cellHeight - cellPadding * 2
                
                
                
                //let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: photoWidth)
                //let height = cellPadding +  photoHeight + annotationHeight + cellPadding
                let width = cellPadding +  cellWidth + cellPadding
                let frame = CGRect(x: xOffset[row], y: yOffset[row], width: cellWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
                let attributes = YSSearchCollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.photoHeight = height
                attributes.frame = insetFrame
                cache.append(attributes)
                
                // 6. Updates the collection view content height
                //contentHeight = max(contentHeight, frame.maxY)
                contentWidth = max(contentWidth, frame.maxX)
                
                //yOffset[column] = yOffset[column] + height
                xOffset[row] = xOffset[row] + width
                
                if row >= numberOfRows - 1 {
                    row = 0
                }
                else
                {
                    row += 1
                }
            }
        }
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        
        cache.removeAll()
        
        prepare()
        //self.collectionView.
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        // Loop through the cache and look for items in the rect
        for attributes  in cache {
            if attributes.frame.intersects(rect ) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}




//
//
//
//
//
//
//import UIKit
//protocol YSSearchCollectionLayoutDelegate {
//    // 1. Method to ask the delegate for the height of the image
//    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth:CGFloat) -> CGFloat
//    // 2. Method to ask the delegate for the height of the annotation text
//
//    func collectionViewColumnRowCount(collectionView:UICollectionView) -> [String:Int]
//    //
//
//}
//
//class YSSearchCollectionLayoutAttributes:UICollectionViewLayoutAttributes {
//
//    // 1. Custom attribute
//    var photoHeight: CGFloat = 0.0
//
//    // 2. Override copyWithZone to conform to NSCopying protocol
//    override func copy(with zone: NSZone?) -> Any {
//        let copy = super.copy(with: zone) as! YSSearchCollectionLayoutAttributes
//        copy.photoHeight = photoHeight
//        return copy
//    }
//
//    // 3. Override isEqual
//    override func isEqual(_ object: Any?) -> Bool {
//        if let attributtes = object as? YSSearchCollectionLayoutAttributes {
//            if( attributtes.photoHeight == photoHeight  ) {
//                return super.isEqual(object)
//            }
//        }
//        return false
//    }
//}
//
//
//class YSSearchCollectionViewLayout: UICollectionViewLayout {
//    //1. Pinterest Layout Delegate
//    public var delegate:YSSearchCollectionLayoutDelegate!
//
//    //2. Configurable properties
//
//    var cellPadding: CGFloat = 6.0
//
//    //3. Array to keep a cache of attributes.
//    fileprivate var cache = [YSSearchCollectionLayoutAttributes]()
//
//    //4. Content height and size
//    var numberOfColumns = 4
//    var numberOfRows = 2
//
//
//    //3. Array to keep a cache of attributes.
//
//    //4. Content height and size
//    fileprivate var contentWidth:CGFloat  = 0.0
//    fileprivate var contentHeight: CGFloat {
//        let insets = collectionView!.contentInset
//        //return collectionView!.bounds.height - (insets.top + insets.bottom)
//        return 200.0 * CGFloat(numberOfRows)
//
//    }
//    //
//    //
//    //    fileprivate var contentHeight: CGFloat {
//    //        let insets = collectionView!.contentInset
//    //        //return collectionView!.bounds.height - (insets.top + insets.bottom)
//    //        return 200.0 * CGFloat(numberOfRows)
//    //
//    //    }
//
//    override class var layoutAttributesClass : AnyClass {
//        return YSSearchCollectionLayoutAttributes.self
//    }
//
//    override func prepare() {
//        // 1. Only calculate once
//        if cache.isEmpty {
//
//            // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
//            //let columnWidth = contentWidth / CGFloat(numberOfColumns)
//
//            let columnHeight = contentHeight / CGFloat(numberOfRows)
//
//
//            var yOffset = [CGFloat]()
//            for column in 0 ..< numberOfRows {
//                yOffset.append(CGFloat(column) * columnHeight )
//            }
//
//            var row = 0
//            var xOffset = [CGFloat](repeating: 0, count: numberOfRows)
//            //var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
//
//            // 3. Iterates through the list of items in the first section
//            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
//
//                let indexPath = IndexPath(item: item, section: 0)
//
//                // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
//                //let width = columnWidth - cellPadding*2
//                let height = columnHeight - cellPadding*2
//
//
//
//                let photoWidth:CGFloat = 150.0
//                let photoHeight:CGFloat = 150.0
//
//                //let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: photoWidth)
//                //let height = cellPadding +  photoHeight + annotationHeight + cellPadding
//                let width = cellPadding +  photoWidth + cellPadding
//                let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: columnHeight)
//                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//                // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
//                let attributes = YSSearchCollectionLayoutAttributes(forCellWith: indexPath)
//                attributes.photoHeight = photoHeight
//                attributes.frame = insetFrame
//                cache.append(attributes)
//
//                // 6. Updates the collection view content height
//                //contentHeight = max(contentHeight, frame.maxY)
//                contentWidth = max(contentWidth, frame.maxX)
//
//                //yOffset[column] = yOffset[column] + height
//                xOffset[row] = xOffset[row] + width
//
//                if row >= numberOfRows - 1 {
//                    row = 0
//                }
//                else
//                {
//                    row += 1
//                }
//            }
//        }
//    }
//
//
////
////    override func prepare() {
////
////
////        if(delegate != nil) {
////
////            let rowColumnCount = delegate.collectionViewColumnRowCount(collectionView: self.collectionView!)
////
////            numberOfRows = rowColumnCount["row"]!
////            numberOfColumns = rowColumnCount["column"]!
////            index = rowColumnCount["index"]!
////
////            //let columnHeight = contentHeight / CGFloat(numberOfRows)
////
////            contentHeight = columnHeight * CGFloat(numberOfRows)
////
////            // 1. Only calcu late once
////            if numberOfColumns > 0 && cache.isEmpty {
////
////                // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
////                //let columnWidth = contentWidth / CGFloat(numberOfColumns)
////
////
////
////                var yOffset = [CGFloat]()
////                for column in 0 ..< numberOfColumns {
////                    yOffset.append(columnHeight * CGFloat(index) )
////                }
////
////                var row = 0
////                var xOffset = [CGFloat](repeating: 0, count: numberOfColumns)
////                //var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
////
////                // 3. Iterates through the list of items in the first section
////                for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
////
////                    let indexPath = IndexPath(item: item, section: 0)
////
////                    // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
////                    //let width = columnWidth - cellPadding*2
////                    let height = columnHeight - cellPadding*2
////
////
////
////                    let photoWidth:CGFloat = 150.0
////                    let photoHeight:CGFloat = 150.0
////
////                    //let annotationHeight = delegate.collectionView(collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: photoWidth)
////                    //let height = cellPadding +  photoHeight + annotationHeight + cellPadding
////                    let width = cellPadding +  photoWidth + cellPadding
////                    let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: columnHeight)
////                    let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
////
////                    // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
////                    let attributes = YSSearchCollectionLayoutAttributes(forCellWith: indexPath)
////                    attributes.photoHeight = photoHeight
////                    attributes.frame = insetFrame
////                    cache.append(attributes)
////
////                    // 6. Updates the collection view content height
////                    //contentHeight = max(contentHeight, frame.maxY)
////                    contentWidth = max(contentWidth, frame.maxX)
////
////                    //yOffset[column] = yOffset[column] + height
////                    xOffset[row] = xOffset[row] + width
////
////
////                }
////            }
////
////        }
////
////    }
////
//    override var collectionViewContentSize : CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
//
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
//    {
//        cache.removeAll()
//
//
//        prepare()
//
//        var layoutAttributes = [UICollectionViewLayoutAttributes]()
//
//        // Loop through the cache and look for items in the rect
//        for attributes  in cache {
//            if attributes.frame.intersects(rect ) {
//                layoutAttributes.append(attributes)
//            }
//        }
//        return layoutAttributes
//    }
//
//}
