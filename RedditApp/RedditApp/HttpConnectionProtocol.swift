//
//  HttpConnectionProtocol.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation

protocol HttpConnectionProtocol {
    
    func get(url: String,
             params: [String: AnyObject],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void)
    func post(url: String,
              params: [String: AnyObject],
              onSuccess: @escaping (AnyObject) -> Void,
              onFailure: @escaping (AnyObject) -> Void)
    func put(url: String,
             params: [String: AnyObject],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void)
    func delete(url: String,
                params: [String: AnyObject],
                onSuccess: @escaping (AnyObject) -> Void,
                onFailure: @escaping (AnyObject) -> Void)
}
