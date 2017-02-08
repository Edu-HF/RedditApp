//
//  DataManager.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import Gloss

class DataManager: NSObject, DataManagerProtocol, InteractorOutputProtocol, ViewControllerProtocol{
    
    static var sharedInstance:DataManagerProtocol = DataManager()
    fileprivate var webServices:WebServicesProtocol
    var news:News?
    
    override init(){
        webServices = WebServices()
    }
    
    func fetchNews(mainView: ViewController) {
        
        let handler = ResponseHandler(onSuccess: { info in
            
            let json = info as! JSON
            let newsD: [String : AnyObject] = ("data" <~~ json)!
            let newsA = newsD["children"] as! NSArray
            
            if newsA.count != 0 {
                
                for new in newsA {
                    let newO:[String : AnyObject] = new as! [String : AnyObject]
                    self.news = News(json: newO["data"] as! JSON)!
                    
                    if self.news != nil {
                        self.saveNews(dataNews: self.news!)
                    }
                }
                mainView.viewDidAppear(true)
            }
        
        }, output: self)
        
        webServices.fetchNews(handler:handler)
    }
    
    func saveNews(dataNews: News) {
        
        let newsTable = DBNews()
        
        newsTable.subredditID = dataNews.subredditID
        newsTable.title = dataNews.title
        newsTable.author = dataNews.author
        newsTable.date = dataNews.date
        newsTable.thumbnailURL = dataNews.thumbnailURL
        newsTable.comments = dataNews.comments
        newsTable.subredditURL = dataNews.subredditURL
        
        if newsTable.save() != 0 {
            print("NEWS SAVED")

        }
    }
    
    func saveUser(userInfo: [String : AnyObject]){
    
        let userTable = DBUser()
        
        userTable.userName = userInfo["first_name"] as! String
        userTable.userLastName = userInfo["last_name"] as! String
        
        let jsonPic = userInfo["picture"] as! JSON
        let dataJson: JSON = ("data" <~~ jsonPic)!
        let picURL: String = ("url" <~~ dataJson)!
        
        userTable.thumbailURL = picURL
        
        if userTable.save() != 0 {
            print("USER SAVED")
            
        }
        
    }
    
    func reloadNewsTable() {}
    func onFailure(_ failure: AnyObject){}
    func onError(_ error: AnyObject){}
    
}
