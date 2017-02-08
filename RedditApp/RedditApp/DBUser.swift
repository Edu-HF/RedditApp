//
//  DBUser.swift
//  RedditApp
//
//  Created by Eduardo on 2/6/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import UIKit

class DBUser: SQLTable {

    var id = -1
    var userName = ""
    var userLastName = ""
    var thumbailURL = ""
    
    override var description:String {
        return "id: \(id), userName: \(userName), userLastName: \(userLastName), thumbailURL: \(thumbailURL)"
    }
}
