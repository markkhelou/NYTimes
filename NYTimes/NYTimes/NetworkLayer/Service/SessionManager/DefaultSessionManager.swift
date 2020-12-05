//
//  DefaultSessionManager.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

public class DefaultSessionManager: SessionManager {
	public let session: URLSession
	public var tasks: [URLSessionTask]
	
	public init(session: URLSession = .shared) {
		self.session = session
		self.tasks = []
	}
	
	public func request(_ urlRequest: URLRequest, completion: @escaping (Result<(Data?, URLResponse?), Error>) -> Void) {
		let targetTask = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
			let response = self.process(response: response, for: data)
			switch response {
			case .success(let data):
				completion(.success(data))
			case.failure(let error):
				completion(.failure(error))
			}
		})
		
		tasks.append(targetTask)
		targetTask.resume()
	}
	
	public func cancel(_ urlRequest: URLRequest) {
		guard let targetTask = tasks.first(where: { $0.currentRequest == urlRequest }) else { return }
		targetTask.cancel()
		tasks.removeAll(where: { $0 == targetTask })
	}
    
    public func cancelAllRequest() {
        tasks.forEach({
            $0.cancel()
        })
        tasks.removeAll()
    }
	
	private func process(response: URLResponse?,
						 for data: Data?) -> Result<(Data?, URLResponse?), NetworkResponseError> {
		guard let response = response as? HTTPURLResponse else { return .failure(.failed) }
		
		switch response.statusCode {
		case 200...299: return .success((data, response))
		case 401...500: return .failure(.authenticationError)
		case 501...599: return .failure(.badRequest)
		case 600: return .failure(.outdated)
		default: return .failure(.failed)
		}
	}
}
