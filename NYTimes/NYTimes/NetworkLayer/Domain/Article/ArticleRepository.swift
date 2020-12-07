//
//  ArticleRepository.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import Foundation

class ArticleRepository {
    static let shared = ArticleRepository()
    
    func getArticles(completion: ((Result<ArticleModel?, Error>) -> ())?) {
        
        NetworkService.request(router: Router.getArticles(period: "1")) { (response: Result<ArticleModel?, Error>) in
            switch response {
            case .success(let results):
                completion?(.success(results))
            case .failure(let error):
                completion?(.failure(error))
            }

        }
    }
}
