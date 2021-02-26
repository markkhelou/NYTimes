//
//  ArticlesUseCase.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
import Combine
import Foundation

protocol ArticlesUseCaseProtocol {
    func requestArticles() -> Future<ArticleModel?, NetworkError>
}

class ArticlesUseCase: ArticlesUseCaseProtocol {
    
    var repository: ArticleRepositoryProtocol
    
    init(repository: ArticleRepositoryProtocol) {
        self.repository = repository
    }
    
    func requestArticles() -> Future<ArticleModel?, NetworkError> {
        return repository.requestArticles()
    }
}
