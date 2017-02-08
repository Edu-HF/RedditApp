//
//  LogInViewController.swift
//  RedditApp
//
//  Created by Eduardo on 2/6/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Gloss

class LogInViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var makeLoginLabel: UILabel!
    @IBOutlet var mainScrollView: UIScrollView!
    let facebookButton = FBSDKLoginButton()
    var userData = [DBUser]()
    var db = SQLiteDB.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        facebookButton.frame = CGRect(x: 10, y: makeLoginLabel.frame.origin.y + 60, width: self.view.frame.size.width - 20, height: 60)
        facebookButton.delegate = self
        mainScrollView.addSubview(facebookButton)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        facebookButton.frame = CGRect(x: 10, y: makeLoginLabel.frame.origin.y + 60, width: size.width - 20, height: 60)
    }
    
    // MARK: Facebook Login Actions and Call save User Information
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print(error)
            return
        }
        
        let userToken = FBSDKAccessToken.current()
        
        if userToken != nil {
            
            let requestFB:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"first_name,last_name,email, picture.type(large)"])
            requestFB.start(completionHandler: { (connection, result, error) -> Void in
                
                if ((error) != nil){
                    print("Error: \(error)")
                }else{
                    let data:[String:AnyObject] = result as! [String : AnyObject]
                    DataManager.sharedInstance.saveUser(userInfo: data)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
        let isClear:Bool = DBUser.remove()
        
        if isClear {
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    @IBAction func cancelAct(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
