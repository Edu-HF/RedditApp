//
//  APIClient.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation

class APIClient: NSObject {

    fileprivate var mainURL: String
    fileprivate var clientHTTP: HttpConnectionProtocol
    
    init(url: String) {
        self.mainURL = url
        self.clientHTTP = HttpConnection()
    }
    
    func request(resource: APIResource, parameters: [String : AnyObject], handler: ResponseHandler) {
        request(resource: resource.rawValue, params: parameters, handler: handler)
    }
    
    func request(resource: String,
                 params: [String: AnyObject],
                 handler: ResponseHandler) {
        clientHTTP.post(url: mainURL + resource,
                   params: params,
                   onSuccess: { data in
                    handler.onSuccess(data)
                    //NOTE: This WS Not Have Status key to Validate Response Code
                    /*var json = data as? [String : AnyObject]
                    if let status = json?["status"] {
                        switch status as! Int {
                        case 100, 200:
                            handler.onSuccess(data)
                        default:
                            handler.onFailure(status)
                        }
                    }*/
        },
                   onFailure: { error in
                    handler.onError(error.description as AnyObject)
        })
    }
}
