//
//  DataManagerProtocol.swift
//  RedditApp
//
//  Created by Eduardo on 2/4/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

protocol DataManagerProtocol {
    
    func fetchNews(mainView: ViewController)
    func saveUser(userInfo: [String : AnyObject])
    
}

