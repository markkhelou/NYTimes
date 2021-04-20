//
//  APIConstant.swift
//  NYTimes
//
//  Created by marc helou on 2/23/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation

struct ApiConstants {
    static let apiKey = (Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String) ?? ""
    static let baseUrl = "API_BASE_URL"
}
