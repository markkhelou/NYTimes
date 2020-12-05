//
//  ParameterEncoder.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
	static func encode<T: Codable>(urlRequest: inout URLRequest, parameters: T) throws
}
