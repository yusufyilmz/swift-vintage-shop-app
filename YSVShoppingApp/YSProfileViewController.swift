//
//  YSProfileViewController.swift
//  ShoppingApp
//
//  Created by yusuf yilmaz on 12/31/16.
//  Copyright © 2016 yusuf yilmaz. All rights reserved.

import UIKit
import FacebookLogin
import FBSDKLoginKit
import SwiftSpinner
import FacebookCore
import Foundation

class YSProfileViewController: UITableViewController
{
    //var profileDict : [String : AnyObject]!
    
    
    let userModel = UserModel()
    let segueListViewController = "TabBarController"
    let item:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                if AccessToken.current != nil {
//                    self.GetProfileInfo()
//
//                }
//                else
//                {
//        
//        
//                }
        
        
        //
        //        let button = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        //        button.delegate = self
        //        button.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
        //       // button.center = view.center
        //        view.addSubview(button)
        //
       
        
        
        
        //        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        //        loginButton.center = view.center
        //
        //        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            return 1
        }
        if(section == 1) {
            return 5
        }
        if(section == 2) {
            return 3
        }
        else {
            return 4
            
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! YSProfileImageTableViewCell
            let button = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
            button.delegate = self
            cell.setLoginCellWithImage(button: button, userModel: userModel)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
            
            
            if indexPath.section == 1 {
                
                if indexPath.row == 0 {
                    
                    cell.textLabel?.text = "Dolabım"

                }
                
                if indexPath.row == 1 {
                    cell.textLabel?.text = "Favorilerim"

                }
                
                if indexPath.row == 2 {
                    cell.textLabel?.text = "Siparişlerim"

                }
                
                if indexPath.row == 3 {
                    cell.textLabel?.text = "Satın aldıklarım"

                }
                
                if indexPath.row == 4 {
                    cell.textLabel?.text = "Tekliflerim"
                    
                }
                

            }
                
            else if indexPath.section == 2 {
                
                if indexPath.row == 0 {
                    
                    cell.textLabel?.text = "Profil Ayarları"
                    
                }
                
                if indexPath.row == 1 {
                    cell.textLabel?.text = "Bildirim Ayarları"
                    
                }
                
                if indexPath.row == 2 {
                    cell.textLabel?.text = "Adreslerim"
                    
                }
            }
                
            else if indexPath.section == 3 {
                
              
                if indexPath.row == 0 {
                    cell.textLabel?.text = "Biz kimiz"
                    
                }
                
                if indexPath.row == 1 {
                    cell.textLabel?.text = "Kullanıcı ve gizlilik sözleşmesi"
                    
                }
                
                if indexPath.row == 2 {
                    cell.textLabel?.text = "Gizlilik ilkeleri"
                    
                }
                
                if indexPath.row == 3 {
                    cell.textLabel?.text = "Geri Bildirim ve yarddım"
                    
                }
                
              
            }
            
            
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return ""
            
        }
        if section == 1 {
            
            
            return "Benim yerim"
        }
            
        if section == 2 {
            
            
            return "Ayarlar"
        }
        else {
            return "Hakkında"
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
            return 300.0
        }  else {
            return 50.0
        }
    }
    
    
    
    //    @IBAction func btnFBLoginPressed(_ sender: AnyObject) {
    //        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    //        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
    //            if (error == nil){
    //                let fbloginresult : FBSDKLoginManagerLoginResult = result!
    //                if fbloginresult.grantedPermissions != nil {
    //                    if(fbloginresult.grantedPermissions.contains("email"))
    //                    {
    //                        self.getFBUserData()
    //                        fbLoginManager.logOut()
    //                    }
    //                }
    //            }
    //        }
    //    }
    //
    //    func getFBUserData(){
    //        if((FBSDKAccessToken.current()) != nil){
    //            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
    //                if (error == nil){
    //                    self.dict = result as! [String : AnyObject]
    //                    print(result!)
    //                    print(self.dict)
    //                }
    //            })
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func GetProfileInfo () {
        
        SwiftSpinner.show("Bekleyiniz...")
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    SwiftSpinner.hide()
                    let profileDict = result as! [String : AnyObject]
                    
                    self.userModel.Email = profileDict["email"] as? String
                    self.userModel.Name = profileDict["name"] as? String
                    self.userModel.LoginId = profileDict["id"] as? String
                    self.userModel.FirstName = profileDict["first_name"] as? String
                    self.userModel.LastName = profileDict["last_name"] as? String
                    let image = profileDict["picture"] as! NSDictionary
                    let imageData = image.object(forKey: "data") as! NSDictionary
                    let imageUrl = imageData.object(forKey: "url") as! String
                    self.userModel.PictureLink = imageUrl
                    let store = ApiModel()
                    store.addUser(userModel: self.userModel)
                    self.tableView.reloadData()
                    //userModel.Email = profileDict[email] as! NSString
                    
                    //var userID = self.profileDict["id"] as! NSString
                    //var facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
                    
                    print(result!)
                    print(profileDict)
                }
            })
        }
    }
    
}


extension YSProfileViewController:  LoginButtonDelegate {
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Did complete login via LoginButton with result )")
        
    }
    
    /**
     Called when the button was used to login and the process finished.
     
     - parameter loginButton: Button that was used to login.
     - parameter result:      The result of the login.
     */
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("Did complete login via LoginButton with result \(result)")
        
        self.GetProfileInfo()
        
        //  self.performTabBarSegue()
        
        
        
        
        
        
        
        
        
        //        let alertController = UIAlertController(title: "Simple", message: "Simple alertView demo with Cancel and Ok.", preferredStyle: UIAlertControllerStyle.alert)
        //
        //
        //        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        //            print("Cancel")
        //        }
        //        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        //            //self.performTabBarSegue()
        //        }
        //
        //
        //        switch result {
        //        case .cancelled:
        //            alertController.title = "Login cancel"
        //            alertController.message = "Cancelled"
        //        case .failed(let error):
        //            alertController.title = "Login Fail"
        //            alertController.message = "Login failed with error \(error)"
        //
        //        case .success(let grantedPermissions, _, _):
        //
        //            alertController.title = "Login Success"
        //            alertController.message = "Login succeeded with granted permissions: \(grantedPermissions)"
        //
        //        }
        //
        //        alertController.addAction(cancelAction)
        //        alertController.addAction(okAction)
        //
        //        self.present(alertController, animated: true, completion: nil)
        //
        
        
    }
    
    
    func performTabBarSegue()
    {
        performSegue(withIdentifier: segueListViewController, sender: self)
        
    }
    //
    //        let loginManager = LoginManager()
    //        loginManager.logIn([ .PublicProfile ], viewController: self) { loginResult in
    //            switch loginResult {
    //            case .Failed(let error):
    //                print(error)
    //            case .Cancelled:
    //                print("User cancelled login.")
    //            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
    //                print("Logged in!")
    //            }
    //
    //            performSegue(withIdentifier: segueListViewController, sender: self)
    
    
}

