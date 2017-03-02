//
//  YSPopupViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 10/31/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.
//

import UIKit



class YSPopupViewController : UIViewController {

    fileprivate let FILTER_CELL_REUSE_IDENTIFIER = "FilterCell"

    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var listButton: UIButton!

    public var collections:[CollectionModel]?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.closeButton.setTitleColor(UIColor.black, for: .normal)
        self.listButton.setTitleColor(UIColor.black, for: .normal)
        self.tableView.dataSource = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.shadowOpacity = 0.8
        self.popUpView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.tableView.register(UINib(nibName: "YSPopupViewCell", bundle: nil), forCellReuseIdentifier: "PopupViewCell")

    }

    open func showInView(_ aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool)
    {
        aView.addSubview(self.view)
        //logoImg!.image = image
        //messageLabel!.text = message
        if animated
        {
            self.showAnimate()
        }
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 2.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

    @IBAction open func closePopup(_ sender: AnyObject) {
        self.removeAnimate()
    }
}

extension YSPopupViewController: UITableViewDelegate, UITableViewDataSource {



    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.collections!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopupViewCell", for: indexPath as IndexPath) as! YSPopupViewCell
        
        //cell.leftLabel.text = collections[(indexPath as NSIndexPath).row].Title
        cell.initialize(title: (collections?[(indexPath as NSIndexPath).row].Title!)!)
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        let cell = tableView.cellForRow(at: indexPath) as! YSPopupViewCell
        
        cell.changeChecked()
        
        //let cb = cell.checkBox.changeChecked()
            
        
        //let bundle = Bundle(for: YSFilterViewController.self)
        
        
        
        //        self.filterPopViewController = YSFilterViewController(nibName: "YSFilterViewController", bundle: bundle)
        //        self.filterPopViewController.title = "This is a popup view"
        //        self.filterPopViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a great popup window", animated: true)
        //
        
        
        //   selectedCollectionDict = collections?.object(at: (indexPath as NSIndexPath).row) as? NSDictionary

        //        selectedCollection = collections?[(indexPath as NSIndexPath).row]
        //
        //
        //        performSegue(withIdentifier: COLLECTIONS_LIST_SEGUE_IDENTIFIER, sender: self)
        //

    }

    func getCheckedImage() -> UIImage {
        let checkedImage = UIImage(named: "CheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        return checkedImage!
    }
    
    func getUnCheckedImage() -> UIImage {
        let uncheckedImage = UIImage(named: "UncheckedCheckbox")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        return uncheckedImage!
    }
    


}

