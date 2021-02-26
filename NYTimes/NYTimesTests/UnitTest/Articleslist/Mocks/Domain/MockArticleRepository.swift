//
//  MockArticleRepository.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

@testable import NYTimes
import Combine

class MockArticleRepository: ArticleRepositoryProtocol {
    var response: Result<Codable, NetworkError>
    init(_ response: Result<Codable, NetworkError>) {
        self.response = response
    }
    
    func requestArticles() -> Future<ArticleModel?, NetworkError> {
        Future { promise in
            switch self.response {
            case .success(let response): promise(.success(response as? ArticleModel))
            case .failure(let error): promise(.failure(error))
            }
        }
    }
}
