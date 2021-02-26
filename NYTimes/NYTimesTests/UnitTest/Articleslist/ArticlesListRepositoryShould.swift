//
//  ArticlesListRepositoryShould.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
@testable import NYTimes
import XCTest
import Combine

class ArticlesListRepositoryShould: XCTestCase {

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
        let remote = MockArticlesRemote(.success(articleModel))
        let repository = ArticleRepository(remote: remote)
        let repoExpectation = expectation(description: "repo-articles")
        var articles: ArticleModel?
        repository.requestArticles().sink { (result) in
            if case .success(let response) = result {
                articles = response
                repoExpectation.fulfill()
            }
        }.store(in: &cancellables)
        wait(for: [repoExpectation], timeout: 1)
        XCTAssertEqual(articles?.results.first?.title, articleModel?.results.first?.title)
    }
    
    func testFailedRequestAllArticles() {
        let remote = MockArticlesRemote(.failure(.unknown))
        let repository = ArticleRepository(remote: remote)
        let repoExpectation = expectation(description: "repo-articles-failed")
        var networkError: NetworkError?
        repository.requestArticles().sink { (result) in
            if case .failure(let error) = result {
                networkError = error as? NetworkError
                repoExpectation.fulfill()
            }
        }.store(in: &cancellables)
        wait(for: [repoExpectation], timeout: 1)
        XCTAssertEqual(networkError?.errorDescription, NetworkError.unknown.errorDescription)
    }
}
