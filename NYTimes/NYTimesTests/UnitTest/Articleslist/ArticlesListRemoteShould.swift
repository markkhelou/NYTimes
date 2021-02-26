//
//  ArticlesListRemoteShould.swift
//  NYTimesTests
//
//  Created by marc helou on 2/24/21.
//  Copyright © 2021 marc helou. All rights reserved.
//
@testable import NYTimes
import XCTest
import Combine

class ArticlesListRemoteShould: XCTestCase {
    
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
        let networkService = MockNetworkService(.success(articleModel))
        let articlesRemote = ArticlesRemote(networkService: networkService)
        let apiExpectation = expectation(description: "Articles")
        var articles: ArticleModel?
        articlesRemote.requestArticles().sink { (result) in
            if case .success(let response) = result {
                articles = response
                apiExpectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [apiExpectation], timeout: 1)
        XCTAssertEqual(articles?.results.first?.title, self.articleModel?.results.first?.title)
        XCTAssertEqual(networkService.queries.keys.count, 1)
        XCTAssertEqual(networkService.queries.keys.first, "api-key")
        XCTAssertEqual(networkService.queries.values.first, "QP5J5EfGIo2SulKxqdHNBS3LcmVPG5lo")
        XCTAssertEqual(networkService.method, .get)
        XCTAssertEqual(networkService.url, ArticlesEndPoint.articles)
    }
    
    func testEmitsErrorResultWhenNetworkFails() {
        let networkService = MockNetworkService(.failure(NetworkError.unknown))
        let articlesRemote = ArticlesRemote(networkService: networkService)
        let apiExpectation = expectation(description: "ArticlesWithError")
        var networkError: NetworkError?
        articlesRemote.requestArticles().sink { (result) in
            if case .failure(let error) = result {
                networkError = error as? NetworkError
                apiExpectation.fulfill()
            }
        }.store(in: &cancellables)
        wait(for: [apiExpectation], timeout: 1)
        XCTAssertEqual(networkError?.errorDescription, NetworkError.unknown.errorDescription)
    }
}
