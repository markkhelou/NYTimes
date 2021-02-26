//
//  File.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

@testable import NYTimes
import XCTest
import Combine

class ArticlesListViewControllerShould: XCTestCase {

    private var articleModel: ArticleModel?
    private var cancellables: [AnyCancellable] = []
    private var viewController: ArticlesListViewController?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        articleModel = MockArticleModel.articleModel
        viewController = ArticlesListViewController(coordinator: MockArticlesCoordinator(), viewModel: MockArticlesViewModel())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil

        articleModel = nil
        cancellables.forEach({ $0.cancel() })
        cancellables.removeAll()
    }
}


class MockArticlesCoordinator: ArticlesNavigator {
    func showDetails(for model: ArticleDetailModel) {
        // TO + 1
    }

    func showAlert(title: String?, message: String?) {
        // To
    }

    func showSearchAlert(completion: ((String?) -> Void)?) {
        // to
    }


}


class MockArticlesViewModel: ArticlesViewModelProtocol {
    private var articlesStateSubject = PassthroughSubject<ArticlesState, Never>()

    func requestArticles() {
        //
    }

    func search(for text: String?) {
        //
    }

    var articlesStatePublisher: AnyPublisher<ArticlesState, Never> {
        articlesStateSubject.eraseToAnyPublisher()
    }


}
