//
//  ArticleRepository.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//
import Combine
import Foundation

protocol ArticleRepositoryProtocol {
    func requestArticles() -> Future<ArticleModel?, NetworkError>
}

class ArticleRepository: ArticleRepositoryProtocol {
    
    var remote: ArticlesRemoteProtocol
    
    init(remote: ArticlesRemoteProtocol) {
        self.remote = remote
    }
    
    func requestArticles() -> Future<ArticleModel?, NetworkError> {
        return remote.requestArticles()
    }
}
