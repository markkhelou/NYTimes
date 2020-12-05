//
//  DefaultImageLoader.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public class DefaultImageLoader: ImageLoader {
	public let manager: SessionManager
	public let cache: URLCache
	
	public init(manager: SessionManager = DefaultSessionManager(), cache: URLCache = .shared) {
		self.manager = manager
		self.cache = cache
	}
	
	public func request(_ urlRequest: URLRequest, forceRefresh: Bool = false, completion: @escaping (Result<Data, Error>) -> Void) {
		if forceRefresh {
			cache.removeCachedResponse(for: urlRequest)
		}
		
		if let data = cache.cachedResponse(for: urlRequest)?.data {
			completion(.success(data))
			return
		}
		
		manager.request(urlRequest, completion: { result in
			switch result {
			case .success(let data, let response):
				guard let data = data, let response = response else {
					completion(.failure(NetworkResponseError.noData))
					return
				}
				let cachedData = CachedURLResponse(response: response, data: data)
				self.cache.storeCachedResponse(cachedData, for: urlRequest)
				completion(.success(data))
			case .failure(let error):
				completion(.failure(error))
			}
		})
	}
	
	public func cancel(_ urlRequest: URLRequest) {
		manager.cancel(urlRequest)
	}
}
