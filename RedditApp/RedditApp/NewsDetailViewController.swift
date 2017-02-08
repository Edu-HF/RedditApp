//
//  NewsDetailViewController.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit
import FBSDKShareKit

class NewsDetailViewController: ViewController, FBSDKSharingDelegate {
    
    @IBOutlet var mainThumbnail: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var commentsNumLabel: UILabel!
    var idSelected:Int = 0
    var dataNews = DBNews()
    var userData = [DBUser]()
    let db = SQLiteDB.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        self.navigationItem.title = "DETAILS"
        
        dataNews = DBNews.rowByID(rid: idSelected) as! DBNews
        
        let imaTask = URLSession.shared.dataTask(with: URL(string: dataNews.thumbnailURL)!) { data, response, error in
            if data == nil {
                let imaN = #imageLiteral(resourceName: "NotPhoto_IC")
                DispatchQueue.main.async {
                    self.mainThumbnail.image = imaN
                }
            }else{
                let imaD = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self.mainThumbnail.image = imaD
                }
            }
        }
        
        imaTask.resume()
        
        titleLabel.text = dataNews.title
        titleLabel.sizeToFit()
        authorLabel.text = "Autor: " + dataNews.author
        dateLabel.text = RedditUtil().giveMeDate(dataIn: dataNews.date)
        commentsNumLabel.text = dataNews.comments
    }
    
    // MARK: - SHARED In Facebook
    @IBAction func sharedFacebookAct(_ sender: Any) {
        
        userData = DBUser.rows(order:"id ASC") as! [DBUser]
        if userData.count == 0 {
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let loginNavegation:LoginNavegationViewController = mainSB.instantiateViewController(withIdentifier: "LoginNavegationViewController") as! LoginNavegationViewController
            self.present(loginNavegation, animated: true, completion: nil)
            
        }else{
            
            let content = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: dataNews.thumbnailURL)! as URL!
            content.contentTitle = dataNews.title
            content.contentDescription = dataNews.title
            
            let shareDialog = FBSDKShareDialog()
            shareDialog.fromViewController = self
            shareDialog.shareContent = content
            shareDialog.delegate = self
            shareDialog.mode = .feedBrowser
            
            shareDialog.show()
        }
    }
    
    // MARK: - Facebook Sharing Delegate Methods
    public func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!){
        print("Complete")
    }
    
    public func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!){
        print("Error FB")
    }
    
    public func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("Cancel")
    }


}
