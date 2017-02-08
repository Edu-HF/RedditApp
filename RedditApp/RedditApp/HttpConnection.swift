//
//  HttpConnection.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class HttpConnection: NSObject, HttpConnectionProtocol {
    
    func get(url: String,
             params: [String: AnyObject],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .get, params: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func post(url: String,
              params: [String: AnyObject],
              onSuccess: @escaping (AnyObject) -> Void,
              onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .post, params: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func put(url: String,
             params: [String: AnyObject],
             onSuccess: @escaping (AnyObject) -> Void,
             onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .put, params: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func delete(url: String,
                params: [String: AnyObject],
                onSuccess: @escaping (AnyObject) -> Void,
                onFailure: @escaping (AnyObject) -> Void) {
        request(url: url, method: .delete, params: params, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func request(url: String,
                 method: HTTPMethod,
                 params: [String: AnyObject],
                 onSuccess: @escaping (AnyObject) -> Void,
                 onFailure: @escaping (AnyObject) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params)
            .validate()
            .responseJSON { response in
                debugPrint(response.request!)
                debugPrint(response.result)
                
                switch response.result {
                case .success(let data):
                    onSuccess(data as AnyObject)
                case .failure(let error):
                    onFailure(error as AnyObject)
                }
        }
    }
}
