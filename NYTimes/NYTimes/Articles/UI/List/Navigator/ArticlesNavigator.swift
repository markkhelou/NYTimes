//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation

protocol ArticlesNavigator: AnyObject {
    /// Presents the articles details screen
    func showDetails(for model: ArticleDetailModel)
    
    func showAlert(title: String?, message: String?)
    func showSearchAlert(completion: ((String?) -> Void)?)
}
