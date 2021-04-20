//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation
import UIKit

/// The application flow coordinator. Takes responsibility about coordinating view controllers and driving the flow
class ApplicationCoordinator: BaseCoordinator {

    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init(navigationController: nil)
    }

    /// Creates all necessary dependencies and starts the flow
    override func start() {
        let rootViewController = BaseNavigationController()
        let articlesCoordinator = ArticlesCoordinator(navigationController: rootViewController)
        articlesCoordinator.start()
        
        self.window.rootViewController = rootViewController
        self.rootViewController = rootViewController
        
        self.childCoordinators = [articlesCoordinator]
        articlesCoordinator.parentCoordinator = self
    }

}
