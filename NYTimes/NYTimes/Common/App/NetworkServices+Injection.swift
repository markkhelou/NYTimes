//
//  NetworkServices+Injection.swift
//  NYTimes
//
//  Created by marc helou on 2/18/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerMyNetworkServices()
    }
}

extension Resolver {
    public static func registerMyNetworkServices() {
        // register network service
        Resolver.register { NetworkService() as NetworkServiceProtocol }
        ArticlesDIResolver.register()
    }
}
