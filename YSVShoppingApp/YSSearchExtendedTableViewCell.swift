import UIKit

class YSSearchExtendedTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    
    @IBOutlet fileprivate weak var cellName: UILabel!
    
    @IBOutlet fileprivate weak var cellButton: UIButton!
    
    
    fileprivate var blurEffect:UIBlurEffect? = nil
    fileprivate var blurView:UIVisualEffectView? = nil


    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blurEffect = UIBlurEffect(style: .light)
        blurView = UIVisualEffectView(effect: blurEffect)
        blurView?.clipsToBounds = true
        blurView?.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        blurView?.layer.borderWidth = 1.0
        blurView?.layer.cornerRadius = 6.0
        
        
     
        // Set the PinterestLayout delegate
 
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    


    
    func setProperties(header: String, buttonTag: Int) {
        cellName.text = header
        cellButton.tag = buttonTag
        //blurView?.contentView.addSubview(cellName)
        
    }
    
    
    
}

extension YSSearchExtendedTableViewCell {

    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {

        let source = dataSourceDelegate as! YSSearchViewController
            
            
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        
        
        if let layout = collectionView?.collectionViewLayout as? YSSearchCollectionViewLayout {
            layout.delegate = source
        }
        
        collectionView!.backgroundColor = UIColor.clear
        //collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
        
        
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}


