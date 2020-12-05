//
//  SessionManager.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public protocol SessionManager: class {
	var session: URLSession { get }
	var tasks: [URLSessionTask] { get }
	
	func request(_ urlRequest: URLRequest, completion: @escaping (Result<(Data?, URLResponse?), Error>) -> Void)
	func cancel(_ urlRequest: URLRequest)
    func cancelAllRequest()
}
