//
//  ArticlesDIResolver.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation
import Resolver

class ArticlesDIResolver {
    static func register() {
        Resolver.register { ArticlesViewModel(useCase: Resolver.resolve()) as ArticlesViewModelProtocol }
        Resolver.register { ArticlesUseCase(repository: Resolver.resolve()) as ArticlesUseCaseProtocol }
        Resolver.register { ArticleRepository(remote: Resolver.resolve()) as ArticleRepositoryProtocol }
        Resolver.register { ArticlesRemote(networkService: Resolver.resolve()) as ArticlesRemoteProtocol }
    }
}
