//
//  EndPointType.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public protocol EndPointType {
	associatedtype BodyParameters: Codable
	associatedtype URLParameters: Codable
	
	var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<BodyParameters, URLParameters> { get }
    var headers: HTTPHeaders? { get }
}
