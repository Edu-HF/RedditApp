//
//  APIManager.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    static let sharedInstance:APIManager = APIManager()
    
    func getClientAPI() -> APIClient {
        return APIClient(url: "https://www.reddit.com/")
    }
}
