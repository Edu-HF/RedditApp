//
//  RedditUtil.swift
//  RedditApp
//
//  Created by Eduardo on 2/5/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import SwiftGifOrigin

class RedditUtil: NSObject {
    
    func giveMeDate(dataIn: String) -> String {
        
        var dateR:String = ""
        
        let date = NSDate(timeIntervalSince1970: Double(dataIn)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateR = dateFormatter.string(from: date as Date)
        
        return dateR
    }
    
    @available(iOS 10.0, *)
    func setupLoading(tableViewIn: UITableView){
        
        tableViewIn.refreshControl = UIRefreshControl()
        
        let refreshLoadingView:UIView = UIView(frame: tableViewIn.refreshControl!.bounds)
        refreshLoadingView.backgroundColor = UIColor.clear
        
        let reddifG = UIImage.gif(name: "LoadingGif")
        let reddifView = UIImageView(frame: CGRect(x:150,y:0,width:70,height:70))
        reddifView.image = reddifG
        
        refreshLoadingView.addSubview(reddifView)
        refreshLoadingView.clipsToBounds = true
        tableViewIn.refreshControl!.tintColor = UIColor.clear
        tableViewIn.refreshControl!.addSubview(refreshLoadingView)
        tableViewIn.refreshControl?.addTarget(self, action: Selector(("refreshL")), for: UIControlEvents.valueChanged)
    }
    
    func setupLoadingForBottom(tableViewIn: UITableView) {
    
        let footerView = UIView(frame: CGRect.zero)
        footerView.backgroundColor = UIColor.darkGray
        
        let reddifG = UIImage.gif(name: "LoadingGif")
        let reddifView = UIImageView(frame: CGRect(x:(tableViewIn.frame.size.width/2)-35,y:0,width:70,height:70))
        reddifView.image = reddifG
        reddifView.backgroundColor = UIColor.clear
        footerView.addSubview(reddifView)
        
        NSLayoutConstraint(
            item: reddifView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0
            ).isActive = true
        
        NSLayoutConstraint(
            item: reddifView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: footerView,
            attribute: .centerY,
            multiplier: 1.0, 
            constant: 0.0
            ).isActive = true
        
        tableViewIn.tableFooterView = footerView

    }
    
}
