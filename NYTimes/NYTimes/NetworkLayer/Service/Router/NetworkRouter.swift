//
//  NetworkRouter.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//
import Foundation

public protocol NetworkRouter: class {
	associatedtype EndPoint: EndPointType
	
	func request<T: Codable>(_ route: EndPoint, completion: @escaping (Result<T?, Error>) -> Void)
	func cancel(_ route: EndPoint)
    func cancelAllRequest()
}
