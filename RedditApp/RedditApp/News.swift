//
//  News.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import Gloss

class News: NSObject, Decodable {

    var subredditID:String
    var title:String
    var author:String
    var date:String
    var thumbnailURL:String
    var comments:String
    var subredditURL:String
    
    init(subredditID: String, title: String, author: String, date: String, thumbnailURL: String, comments: String, subredditURL: String) {
        
        self.subredditID = subredditID
        self.title = title
        self.author = author
        self.date = date
        self.thumbnailURL = thumbnailURL
        self.comments = comments
        self.subredditURL = subredditURL
    }
    
    required init?(json: JSON) {
        
        guard let sID: String = "subreddit_id" <~~ json else {
            return nil
        }
        
        let num_c:Int64 = ("num_comments" <~~ json)!
        let num_d:Int64 = ("created" <~~ json)!
        
        self.subredditID = sID
        self.title = ("title" <~~ json)!
        self.author = ("author" <~~ json)!
        self.date = String(num_d)
        self.comments = String(num_c)
        self.thumbnailURL = ("thumbnail" <~~ json)!
        self.subredditURL = ("url" <~~ json)!
    }
}
