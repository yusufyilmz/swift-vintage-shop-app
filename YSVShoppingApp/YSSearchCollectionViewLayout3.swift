//
//
//import UIKit
//
//protocol YSCollectionLayoutDelegate {
//    
//    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath, withWidth:CGFloat) -> CGFloat
//    
//    func collectionViewColumnCount(collectionView:UICollectionView) -> Int
//    
//    func collectionViewRowCount(collectionView:UICollectionView) -> Int
//
//}
//
//
//class YSSearchCollectionLayoutAttributes:UICollectionViewLayoutAttributes {
//    
//    
//    
//    // 1. Custom attribute
//    var photoHeight: CGFloat = 0.0
//    
//    // 2. Override copyWithZone to conform to NSCopying protocol
//    override func copy(with zone: NSZone?) -> Any {
//        
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
//    
//    // 1
//    var delegate: YSCollectionLayoutDelegate!
//    
//    var numberOfColumns =  0
//    var numberOfRows =  0
//    
//    var cellPadding: CGFloat = 3.0
//    
//    fileprivate var cache = [YSSearchCollectionLayoutAttributes]()
//    
//    // 4
//    //    private var contentHeight:  CGFloat {
//    //    let insets = collectionView!.contentInset
//    //    return collectionView!.bounds.height + insets.top + insets.bottom
//    //    }
//    
//    private var contentWidth: CGFloat  = 0.0
//    private var contentHeight: CGFloat {
//        let insets = collectionView!.contentInset
//        return collectionView!.bounds.height - (insets.top + insets.bottom)
//    }
//    
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//        
//    }
//    
//    override class var layoutAttributesClass : AnyClass {
//        return YSSearchCollectionLayoutAttributes.self
//    }
//    
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        
//        
//        numberOfColumns =  delegate.collectionViewColumnCount(collectionView :self.collectionView!)
//        numberOfRows =  delegate.collectionViewRowCount(collectionView: self.collectionView!)
//    
//        
//        
//        cache.removeAll()
//        
//        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        let scrollDirection = UICollectionViewScrollDirection.horizontal
//        flowLayout.scrollDirection = scrollDirection
//        self.collectionView?.collectionViewLayout = flowLayout
//        
//        prepare()
//
//        
//        var layoutAttributes = [UICollectionViewLayoutAttributes]()
//        
//        self.collectionView?.collectionViewLayout = flowLayout
//        
//        for attributes in cache {
//            if attributes.frame.intersects(rect) {
//                layoutAttributes.append(attributes)
//            }
//        }
//        return layoutAttributes
//    }
//    
//    
//    override func prepare() {
//        // 1
//        
//        //  collectionView?.isScrollEnabled = false
//        
//        //collectionView!.contentInset.top = 0
//        
//        if cache.isEmpty {
//            // 2
//        
//            let columnWidth = contentWidth / CGFloat(numberOfColumns)
//            
//            var xOffset = [CGFloat]()
//            for column in 0 ..< numberOfColumns {
//                xOffset.append(CGFloat(column) * columnWidth )
//            }
//            var column = 0
//            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
//            
//            
//            
//            // 3
//            var i:CGFloat  = 0
//            for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
//                
//                let indexPath = NSIndexPath(item: item, section: 0)
//                i = i + 1
//                // 4
//                let width = columnWidth - cellPadding * 2
//                
//                //                let photoHeight = delegate.collectionView(collectionView: self.collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
//                //
//                //                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
//                let annotationHeight:CGFloat = 100.0
////                let buttonHeight:CGFloat = 25.0
//                
//                let height = cellPadding + annotationHeight + cellPadding
//                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
//                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//                
//                let attributes = YSSearchCollectionLayoutAttributes(forCellWith: indexPath as IndexPath)
//                attributes.frame = insetFrame
//                cache.append(attributes)
//                
//                contentHeight = max(contentHeight, frame.maxY * i / 2)
//                
//                xOffset[column] = xOffset[column] + contentWidth
//
//                if column >= numberOfColumns - 1 {
//                    column = 0
//                }
//                else
//                {
//                    column += 1
//                }
//                //column = column >= (numberOfColumns - 1) ? 0 : column
//            }
//        }
//    }
//}
