//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by marc helou on 12/5/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {
    
    var aticlesViewModel: ArticlesViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        aticlesViewModel = ArticlesViewModel()
        aticlesViewModel.articles = [ArticleResultsModel(
            title: "How Is Trump’s Lawyer Jenna Ellis ‘Elite Strike Force’ Material?",
            byline: "By Jeremy W. Peters and Alan Feuer",
            abstract: "She bills herself as a “constitutional law attorney.” Her experience doesn’t align with the sort of lawyer she plays on TV.",
            published_date: "2020-12-03",
            source: "New York Times",
            media: [ArticleMediaModel(caption: "Jenna Ellis’s roles as a spokeswoman and a social media activist for President Trump have taken on new prominence as his legal efforts to overturn the election have slowly petered out.", mediaMetadata: [ArticleMediaMetaDataModel(url: "https://static01.nyt.com/images/2020/12/02/us/politics/02ellis1/02ellis1-thumbStandard.jpg"),ArticleMediaMetaDataModel(url: "https://static01.nyt.com/images/2020/12/02/us/politics/02ellis1/merlin_180218334_87959c5e-af90-4ee5-b93c-2e11c68a3602-mediumThreeByTwo440.jpg")
                ]
                )])]
        aticlesViewModel.fillArticles(articles: aticlesViewModel.articles)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        aticlesViewModel = nil
    }
    
    func testGetArticles() {
        assert(aticlesViewModel.articlesModelList.count == aticlesViewModel.articles.count)
        assert(aticlesViewModel.articlesModelList.count == aticlesViewModel.filteredArticlesModelList.count)
    }
    
    func testMapForArticleList() {
        assert(aticlesViewModel.articles.first?.title == aticlesViewModel.articlesModelList.first?.title)
        assert(aticlesViewModel.articles.first?.byline == aticlesViewModel.articlesModelList.first?.byline)
        assert(aticlesViewModel.articles.first?.published_date == aticlesViewModel.articlesModelList.first?.date)
        assert(aticlesViewModel.articles.first?.media?.first?.mediaMetadata?.first?.url == aticlesViewModel.articlesModelList.first?.imageURLString)
    }
    
    func testMapForArticleDetail() {
        let model = aticlesViewModel.getArticleDetailsModel(at: 0)
        assert(aticlesViewModel.articles.first?.title == model.title)
        assert(aticlesViewModel.articles.first?.byline == model.byline)
        assert(aticlesViewModel.articles.first?.published_date == model.date)
        assert(aticlesViewModel.articles.first?.media?.first?.mediaMetadata?.last?.url == model.imageURL)
        assert(aticlesViewModel.articles.first?.abstract == model.abstract)
        assert(aticlesViewModel.articles.first?.source == model.navigationTitle)
        assert(aticlesViewModel.articles.first?.media?.first?.caption == model.caption)
    }
    
    func testSearch() {
        aticlesViewModel.search(for: nil)
        assert(aticlesViewModel.filteredArticlesModelList.count == aticlesViewModel.articles.count)
        aticlesViewModel.search(for: "How is")
        assert(aticlesViewModel.filteredArticlesModelList.count == 1)
        aticlesViewModel.search(for: "test")
        assert(aticlesViewModel.filteredArticlesModelList.isEmpty)
    }
    
}
