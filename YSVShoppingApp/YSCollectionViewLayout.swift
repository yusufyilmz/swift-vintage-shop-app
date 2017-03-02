//
//  YSCollectionViewLayout.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/12/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit

//protocol YSCollectionLayoutDelegate {
//    
//    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
//    
//    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
//}

class YSCollectionLayoutAttributes:UICollectionViewLayoutAttributes {
    

    
    // 1. Custom attribute
    var photoHeight: CGFloat = 0.0
    
    // 2. Override copyWithZone to conform to NSCopying protocol
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! YSCollectionLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    // 3. Override isEqual
    override func isEqual(_ object: Any?) -> Bool {
        if let attributtes = object as? YSCollectionLayoutAttributes {
            if( attributtes.photoHeight == photoHeight  ) {
                return super.isEqual(object)
            }
        }
        return false
    }
}


class YSCollectionViewLayout: UICollectionViewLayout {
    
    // 1
    //var delegate: YSCollectionLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding: CGFloat = 3.0
    
    fileprivate var cache = [YSCollectionLayoutAttributes]()

    // 4
//    private var contentHeight:  CGFloat {
//    let insets = collectionView!.contentInset
//    return collectionView!.bounds.height + insets.top + insets.bottom
//    }
    
    private var contentHeight = CGFloat()
    
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)

//        return collectionView!.bounds.width - (insets.left + insets.right-1)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)

    }
    
    override class var layoutAttributesClass : AnyClass {
        return YSCollectionLayoutAttributes.self
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        cache.removeAll()
        
        prepare()

        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
  
    override func prepare() {
        // 1
        
      //  collectionView?.isScrollEnabled = false

        collectionView!.contentInset.top = 0
        
        
        if cache.isEmpty {
            // 2
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            for column in 0 ..< numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth )
            }
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            for column in 0 ..< numberOfColumns {
                yOffset.append(CGFloat(column) * columnWidth )
            }
            // 3
            var i:CGFloat  = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {

                let indexPath = NSIndexPath(item: item, section: 0)
                i = i + 1
                // 4
                let width = columnWidth - cellPadding * 2
                
//                let photoHeight = delegate.collectionView(collectionView: self.collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
//                
//                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                let photoHeight:CGFloat = 150.0
                let annotationHeight:CGFloat = 50.0
                let buttonHeight:CGFloat = 25.0

                let height = cellPadding +  photoHeight + buttonHeight + annotationHeight + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = YSCollectionLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                cache.append(attributes)
        
                contentHeight = max(contentHeight, frame.maxY * i / 2)
                
                yOffset[column] = yOffset[column] + height
                
                if column >= numberOfColumns - 1 {
                    column = 0
                }
                else
                {
                    column += 1
                }
                //column = column >= (numberOfColumns - 1) ? 0 : column
            }
        }
    }
}
