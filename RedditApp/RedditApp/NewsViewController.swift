//
//  NewsViewController.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit

class NewsViewController: ViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerProtocol, FBSDKSharingDelegate {
    
    @IBOutlet var mainNewsTable: UITableView!
    var dataNews = [DBNews]()
    var userData = [DBUser]()
    let db = SQLiteDB.sharedInstance
    var idSelected:Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainNewsTable.rowHeight = UITableViewAutomaticDimension
        mainNewsTable.estimatedRowHeight = 140
        mainNewsTable.backgroundColor = UIColor.darkGray
        
        dataNews = DBNews.rows(order:"id ASC") as! [DBNews]
        if dataNews.count == 0 {
           DataManager.sharedInstance.fetchNews(mainView: self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isFirthLaunch()
        reloadNewsTable()
        setupTableLoadingAnimations()
    }
    
    // MARK: This is for Table Top And Footer Loading Animations
    func setupTableLoadingAnimations() {
    
        RedditUtil().setupLoadingForBottom(tableViewIn: mainNewsTable)
        if #available(iOS 10.0, *) {
            RedditUtil().setupLoading(tableViewIn: mainNewsTable)
        } else {
            print("Ups! Sorry, i forgot create this view in UITableViewController")
        }
    }

    // MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier:String = "newsCell"
        
        var newsCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? NewsTableViewCell
        
        if newsCell == nil {
            tableView.register(UINib(nibName: "newsCell", bundle: nil), forCellReuseIdentifier: identifier)
            newsCell = (tableView.dequeueReusableCell(withIdentifier: identifier) as? NewsTableViewCell)!
        }
        
        let dataN = dataNews[indexPath.row]
        
        let url = URL(string: dataN.thumbnailURL)
        let imaTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            let newsCell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell
            if data == nil {
                let imaN = #imageLiteral(resourceName: "NotPhoto_IC")
                DispatchQueue.main.async {
                    newsCell?.cellThumbnail.image = imaN
                }
            }else{
                let imaD = UIImage(data: data!)!
                DispatchQueue.main.async {
                    newsCell?.cellThumbnail.image = imaD
                }
            }
        }
        
        imaTask.resume()
        
        newsCell?.cellTitle.text = dataN.title
        newsCell?.cellAuthor.text = "Autor: " + dataN.author
        newsCell?.cellDate.text = RedditUtil().giveMeDate(dataIn: dataN.date)
        newsCell?.cellCommentsNum.text = dataN.comments
        newsCell?.cellFacebookButton.addTarget(self, action:#selector(sharedInFB(_:)), for: .touchUpInside)
        
        return newsCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataN = dataNews[indexPath.row]
        idSelected = dataN.id
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func reloadNewsTable() {
        dataNews = DBNews.rows(order:"id ASC") as! [DBNews]
        DispatchQueue.main.async{
            self.mainNewsTable.reloadData()
        }
    }
    
    @available(iOS 10.0, *)
    func refreshL(){

        let delayInSeconds = DispatchTime.now() + 4
        DispatchQueue.main.asyncAfter(deadline: delayInSeconds) {
            self.mainNewsTable.refreshControl!.endRefreshing()
        }
    }
    
    // MARK: - SHARED In Facebook
    func sharedInFB(_ sender: Any) {
        
        userData = DBUser.rows(order:"id ASC") as! [DBUser]
        if userData.count == 0 {
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let loginNavegation:LoginNavegationViewController = mainSB.instantiateViewController(withIdentifier: "LoginNavegationViewController") as! LoginNavegationViewController
            self.present(loginNavegation, animated: true, completion: nil)
            
        }else{
            
            let index:Int = (sender as AnyObject).tag
            let dataN = dataNews[index]
            
            let content = FBSDKShareLinkContent()
            content.contentURL = NSURL(string: dataN.thumbnailURL)! as URL!
            content.contentTitle = dataN.title
            content.contentDescription = dataN.title
            
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail", let detailView = segue.destination as? NewsDetailViewController {
            detailView.idSelected = idSelected
        }
    }
    
    // MARK: - Show LogIn View if is Firth Launch of the App
    func isFirthLaunch() {
    
        if UserDefaults.standard.bool(forKey: "HasLaunchedOnce") {
            
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let loginNavegation:LoginNavegationViewController = mainSB.instantiateViewController(withIdentifier: "LoginNavegationViewController") as! LoginNavegationViewController
            self.present(loginNavegation, animated: true, completion: nil)
        }
    }
    
}
