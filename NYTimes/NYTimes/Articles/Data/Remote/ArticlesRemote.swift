//
//  ArticlesWorker.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
import Combine
import Foundation

protocol ArticlesRemoteProtocol {
    func requestArticles() -> Future<ArticleModel?, NetworkError>
}

class ArticlesRemote: ArticlesRemoteProtocol {
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func requestArticles() -> Future<ArticleModel?, NetworkError> {
        networkService
            .withURL(ArticlesEndPoint.articles)
            .withQueries(["api-key": ApiConstants.apiKey])
            .request()
    }
}
