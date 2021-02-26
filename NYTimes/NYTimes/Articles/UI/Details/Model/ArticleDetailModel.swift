//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 12/5/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

protocol ArticleDetailModel {
    var navigationTitle: String? { get }
    var title: String? { get }
    var byline: String? { get }
    var abstract: String? { get }
    var imageURL: String? { get }
    var caption: String? { get }
    var date: String? { get }
}
