//
//  ArticleModel.swift
//  NYTimesTests
//
//  Created by marc helou on 2/26/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation
@testable import NYTimes

struct MockArticleModel {
    static let articleModel = ArticleModel(
        results: [
            ArticleResultsModel(title: "How Is Trump’s Lawyer Jenna Ellis ‘Elite Strike Force’ Material?",
                                byline: "By Jeremy W. Peters and Alan Feuer",
                                abstract: "She bills herself as a “constitutional law attorney.” Her experience doesn’t align with the sort of lawyer she plays on TV.",
                                published_date: "2020-12-03",
                                source: "New York Times",
                                media: [ArticleMediaModel(caption: "Jenna Ellis’s roles as a spokeswoman and a social media activist for President Trump.", mediaMetadata: [ArticleMediaMetaDataModel(url: "https://static01.nyt.com/images/2020/12/02/us/politics/02ellis1/02ellis1-thumbStandard.jpg")]
                                )])])
}
