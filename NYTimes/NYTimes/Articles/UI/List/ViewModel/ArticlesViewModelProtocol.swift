//
//  ArticlesViewModelType.swift
//  NYTimes
//
//  Created by marc helou on 2/23/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
import Combine
import Foundation

enum ArticlesState {
    case idle
    case loading
    case success([ArticleResultsModel])
    case noResults
    case failure(Error)
}

protocol ArticlesViewModelProtocol: class {
    func requestArticles()
    func search(for text: String?)
    var  articlesStatePublisher: AnyPublisher<ArticlesState, Never> { get }
}
