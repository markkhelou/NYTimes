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

struct ArticleResultsModel: Codable {
    var title: String?
    var byline: String?
    var abstract: String?
    var published_date: String?
    var source: String?
    var media: [ArticleMediaModel]?
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
