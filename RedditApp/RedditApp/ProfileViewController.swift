//
//  ProfileViewController.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit


class ProfileViewController: ViewController {
    
    @IBOutlet var userPic: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userLastName: UILabel!
    @IBOutlet var userLogOutButton: UIButton!
    
    var userData = [DBUser]()
    var db = SQLiteDB.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI() {
        
        userData = DBUser.rows(order:"id ASC") as! [DBUser]
        if userData.count == 0 {
            userPic.image = #imageLiteral(resourceName: "ProfileDefault_IC")
            userName.text = "Not User Log Yet"
            userLastName.text = " "
            userLogOutButton.isHidden = true
            return
        }
        
        userLogOutButton.isHidden = false
        let dataU = userData[0]
        let url = URL(string: dataU.thumbailURL)
        let imaTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            if data == nil {
                let imaN = #imageLiteral(resourceName: "ProfileDefault_IC")
                DispatchQueue.main.async {
                    self.userPic.image = imaN
                }
            }else{
                let imaD = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self.userPic.image = imaD
                }
            }
        }
        
        imaTask.resume()
        
        userName.text = dataU.userName
        userLastName.text = dataU.userLastName
    }
    
    @IBAction func userLogOutButtonAct(_ sender: UIButton) {
        
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let loginNavegation:LoginNavegationViewController = mainSB.instantiateViewController(withIdentifier: "LoginNavegationViewController") as! LoginNavegationViewController
        self.present(loginNavegation, animated: true, completion: nil)
    }
    

}
