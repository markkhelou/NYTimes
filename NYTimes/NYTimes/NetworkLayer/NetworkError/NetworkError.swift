//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 12/5/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public enum NetworkRequestError: String, Error {
    case missingURL
}

public enum NetworkResponseError: String, Error {
    case noResponse
    case noData
}
