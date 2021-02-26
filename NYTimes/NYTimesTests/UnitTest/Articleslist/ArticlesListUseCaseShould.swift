//
//  ArticlesListUseCaseShould.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

@testable import NYTimes
import XCTest
import Combine

class ArticlesListUseCaseShould: XCTestCase {
    
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
    
    func testRequestAllArticles() {
        let repository = MockArticleRepository(.success(articleModel))
        let useCase = ArticlesUseCase(repository: repository)
        let useCaseExpectation = expectation(description: "usecase-artciles")
        var articles: ArticleModel?
        useCase.requestArticles().sink { (result) in
            if case .success(let response) = result {
                articles = response
                useCaseExpectation.fulfill()
            }
        }.store(in: &cancellables)
        wait(for: [useCaseExpectation], timeout: 1)
        XCTAssertEqual(articles?.results.first?.title, articleModel?.results.first?.title)
    }
    
    func testFailedRequestAllArticles() {
        let repository = MockArticleRepository(.failure(.unknown))
        let useCase = ArticlesUseCase(repository: repository)
        let useCaseExpectation = expectation(description: "repo-artciles-failed")
        var networkError: NetworkError?
        useCase.requestArticles().sink { (result) in
            if case .failure(let error) = result {
                networkError = error as? NetworkError
                useCaseExpectation.fulfill()
            }
        }.store(in: &cancellables)
        wait(for: [useCaseExpectation], timeout: 1)
        XCTAssertEqual(networkError?.errorDescription, NetworkError.unknown.errorDescription)
    }
}
