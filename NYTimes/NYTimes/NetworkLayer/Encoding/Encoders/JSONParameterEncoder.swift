//
//  JSONParameterEncoder.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
	static func encode<T: Codable>(urlRequest: inout URLRequest, parameters: T) throws {
		do {
			let jsonAsData = try JSONEncoder().encode(parameters)
			urlRequest.httpBody = jsonAsData
			if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
				urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
			}
		}
		catch {
			throw NetworkRequestError.encodingFailed
		}
	}
}
