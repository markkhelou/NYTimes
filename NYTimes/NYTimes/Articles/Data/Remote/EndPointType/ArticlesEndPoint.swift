//
//  ArticlesEndPoint.swift
//  NYTimes
//
//  Created by marc helou on 2/23/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation

struct ArticlesEndPoint: Endpoint {
    static var articles: String = path("/svc/mostpopular/v2/viewed/1.json")
}
