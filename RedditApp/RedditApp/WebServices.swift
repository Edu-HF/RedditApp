//
//  WebServices.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation

class WebServices: NSObject, WebServicesProtocol {
    
    fileprivate var clientAPI: APIClient
    
    override init() {
        clientAPI = APIManager.sharedInstance.getClientAPI()
    }
    
    func fetchNews(handler: ResponseHandler) {
        clientAPI.request(resource: .news, parameters: [:], handler: handler)
    }
}
