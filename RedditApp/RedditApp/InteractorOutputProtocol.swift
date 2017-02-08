//
//  InteractorOutputProtocol.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import Foundation

protocol InteractorOutputProtocol {
    func onFailure(_ failure: AnyObject)
    func onError(_ error: AnyObject)
}
