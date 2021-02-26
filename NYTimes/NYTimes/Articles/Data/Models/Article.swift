//
//  Articles.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

struct ArticleModel: Codable {
    var results: [ArticleResultsModel]
}

struct ArticleMediaModel: Codable {
    var caption: String?
    var mediaMetadata: [ArticleMediaMetaDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case caption
        case mediaMetadata = "media-metadata"
    }
}

struct ArticleMediaMetaDataModel: Codable {
    var url: String?
}

struct ArticleResultsModel: Codable {
    var title: String?
    var byline: String?
    var abstract: String?
    var published_date: String?
    var source: String?
    var media: [ArticleMediaModel]?
}

extension ArticleResultsModel: ArticleTableViewCellProtocol {
    var date: String? { published_date }
    var imageURLString: String? { media?.first?.mediaMetadata?.first?.url }
}

extension ArticleResultsModel: ArticleDetailModel {
    var navigationTitle: String? {
        source
    }
    
    var imageURL: String? {
        media?.first?.mediaMetadata?.last?.url
    }
    
    var caption: String? {
        media?.first?.caption
    }
}
