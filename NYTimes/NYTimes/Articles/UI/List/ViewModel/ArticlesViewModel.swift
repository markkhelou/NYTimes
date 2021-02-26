//
//  file.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//
import Combine
import Foundation

class ArticlesViewModel {
    
    private var articles: [ArticleResultsModel] = []
    private var articlesStateSubject = PassthroughSubject<ArticlesState, Never>()
    private var cancellables: [AnyCancellable] = []
    private var useCase: ArticlesUseCaseProtocol
    
    init(useCase: ArticlesUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension ArticlesViewModel: ArticlesViewModelProtocol {
    
    var articlesStatePublisher: AnyPublisher<ArticlesState, Never> {
        articlesStateSubject.receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
    
    func requestArticles() {
        cancellables.forEach({ $0.cancel() })
        cancellables.removeAll()
        
        articlesStateSubject.send(.loading)
        useCase.requestArticles()
            .sink { [weak self] result in
                guard let self = self else { return }
                self.articlesStateSubject.send(.idle)
                switch result {
                case .success(let articles):
                    let articlesModel = articles?.results ?? []
                    if articlesModel.isEmpty {
                        self.articlesStateSubject.send(.noResults)
                    } else {
                        self.articlesStateSubject.send(.success(articlesModel))
                    }
                    self.articles = articles?.results ?? []
                case .failure(let error):
                    self.articlesStateSubject.send(.failure(error))
                }
            }.store(in: &cancellables)
    }
    
    func search(for text: String?) {
        var articlesModel = articles
        if let text = text, !text.isEmpty {
            let filteredModel = articles.filter({ ($0.title?.lowercased().contains(text.lowercased()) ?? false)})
            articlesModel = filteredModel
        }
        if articlesModel.isEmpty {
            articlesStateSubject.send(.noResults)
        } else {
            articlesStateSubject.send(.success(articlesModel))
        }
    }
}
