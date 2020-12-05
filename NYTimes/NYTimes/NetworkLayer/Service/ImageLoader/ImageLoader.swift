//
//  ImageLoader.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public protocol ImageLoader: class {
	var manager: SessionManager { get }
	var cache: URLCache { get }
	
	func request(_ urlRequest: URLRequest, forceRefresh: Bool, completion: @escaping (Result<Data, Error>) -> Void)
	func cancel(_ urlRequest: URLRequest)
}
