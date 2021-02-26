//
//  ArticlesListViewModelShould.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

@testable import NYTimes
import XCTest
import Combine

class ArticlesListViewModelShould: XCTestCase {
    
    private var articleModel: ArticleModel?
    private var cancellables: [AnyCancellable] = []
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        articleModel = MockArticleModel.articleModel
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        articleModel = nil
        cancellables.forEach({ $0.cancel() })
        cancellables.removeAll()
    }
    
    func testRequestAllArticlesWithSuccessState() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(articleModel))
        let viewModel = ArticlesViewModel(useCase: useCase)
        
        var articles: [ArticleResultsModel]?
        let viewModelExpectation = expectation(description: "viewModel-artciles")
        viewModel.articlesStatePublisher.sink { (result) in
            if case .success(let response) = result {
                articles = response
                viewModelExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.requestArticles()
        wait(for: [viewModelExpectation], timeout: 1)
        
        //Than
        XCTAssertEqual(articles?.first?.title, articleModel?.results.first?.title)
    }
    
    func testRequestAllArticlesWithNoResultsState() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(ArticleModel(results: [])))
        let viewModel = ArticlesViewModel(useCase: useCase)
        
        var noResult: Bool?
        let viewModelExpectation = expectation(description: "viewModel-artciles-noResults")
        viewModel.articlesStatePublisher.sink { (result) in
            if case .noResults = result {
                noResult = true
                viewModelExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.requestArticles()
        wait(for: [viewModelExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(noResult, true)
    }
    
    func testRequestAllArticlesWithLoadingState() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(articleModel))
        let viewModel = ArticlesViewModel(useCase: useCase)
        let useCaseExpectation = expectation(description: "viewModel-artciles-loading")
        var isLoading: Bool?
        viewModel.articlesStatePublisher.sink { (result) in
            if case .loading = result {
                isLoading = true
                useCaseExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.requestArticles()
        wait(for: [useCaseExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(isLoading, true)
    }
    
    func testRequestAllArticlesWithIdleState() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(articleModel))
        let viewModel = ArticlesViewModel(useCase: useCase)
        let useCaseExpectation = expectation(description: "viewModel-artciles-idle")
        var isIdle: Bool?
        viewModel.articlesStatePublisher.sink { (result) in
            if case .idle = result {
                isIdle = true
                useCaseExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.requestArticles()
        wait(for: [useCaseExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(isIdle, true)
    }
    
    func testFailedRequestAllArticles() {
        // GIVEN
        let useCase = MockArticleUseCase(.failure(.unknown))
        let viewModel = ArticlesViewModel(useCase: useCase)
        let useCaseExpectation = expectation(description: "viewModel-artciles-failed")
        var networkError: NetworkError?
        viewModel.articlesStatePublisher.sink { (result) in
            if case .failure(let error) = result {
                networkError = error as? NetworkError
                useCaseExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.requestArticles()
        wait(for: [useCaseExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(networkError?.errorDescription, NetworkError.unknown.errorDescription)
    }
    
    func testSearchArticleWithResult() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(articleModel))
        let viewModel = ArticlesViewModel(useCase: useCase)
        viewModel.requestArticles()
        
        let viewModelExpectation = expectation(description: "viewModel-artciles-searchWithResult")
        var articles: [ArticleResultsModel]?
        viewModel.articlesStatePublisher.sink { (result) in
            if case .success(let response) = result {
                articles = response
                viewModelExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.search(for: "Lawyer Jenna Ellis")
        wait(for: [viewModelExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(articles?.count, 1)
    }
    
    func testSearchArticleWithNoResult() {
        // GIVEN
        let useCase = MockArticleUseCase(.success(articleModel))
        let viewModel = ArticlesViewModel(useCase: useCase)
        viewModel.requestArticles()
        let viewModelExpectation = expectation(description: "viewModel-artciles-searchWithNoResult")
        var noResults: Bool?
        viewModel.articlesStatePublisher.sink { (result) in
            if case .noResults = result {
                noResults = true
                viewModelExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        // When
        viewModel.search(for: "Lawyer Jenna Ellis Test")
        wait(for: [viewModelExpectation], timeout: 1)
        
        // Than
        XCTAssertEqual(noResults, true)
    }
}
