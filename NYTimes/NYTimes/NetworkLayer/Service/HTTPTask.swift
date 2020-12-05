//
//  HTTPTask.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask<BodyParameter: Codable, URLParameter: Codable> {
	case request
	case requestParameters(bodyParameters: BodyParameter?, urlParameters: URLParameter?)
	case requestParametersAndHeaders(bodyParameters: BodyParameter?, urlParameters: URLParameter?, headers: HTTPHeaders?)
}
