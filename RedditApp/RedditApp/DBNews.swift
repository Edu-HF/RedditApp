//
//  DBNews.swift
//  RedditApp
//
//  Created by Eduardo on 2/4/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import UIKit

class DBNews:SQLTable {

    var id = -1
    var subredditID = ""
    var title = ""
    var author = ""
    var date = ""
    var thumbnailURL = ""
    var comments = ""
    var subredditURL = ""
    
    override var description:String {
        return "id: \(id), subredditID: \(subredditID), title: \(title), author: \(author), date: \(date), thumbnailURL: \(thumbnailURL), comments: \(comments), subredditURL: \(subredditURL)"
    }
}
