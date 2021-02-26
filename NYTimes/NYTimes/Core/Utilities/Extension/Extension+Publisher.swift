//
//  Extension+Publisher.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Combine

extension Future {
    func sink(_ result: @escaping (Result<Output, Error>) -> Void ) -> AnyCancellable {
        sink(receiveCompletion: { (response) in
            switch response {
            case .failure(let error): result(.failure(error))
            default: break
            }
        }, receiveValue: { (output) in
            result(.success(output))
        })
    }
}
