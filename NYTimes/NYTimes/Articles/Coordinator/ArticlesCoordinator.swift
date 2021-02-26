//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation
import UIKit
import Resolver

class ArticlesCoordinator: BaseCoordinator {
    
    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }

    override func start() {
        let viewController = ArticlesListViewController(coordinator: self, viewModel: Resolver.resolve())
        rootViewController = viewController
        navigationController?.setViewControllers([viewController], animated: false)
    }
}

extension ArticlesCoordinator: ArticlesNavigator {
    
    func showDetails(for model: ArticleDetailModel) {
        let viewController = ArticleDetailsViewController(model: model)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: NSLocalizedString("button.ok", comment: ""),
                                        style: .cancel, handler: nil))
        navigationController?.present(alertController, animated: true)
    }
    
    func showSearchAlert(completion: ((String?) -> Void)?) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("search", comment: ""), style: .default, handler: { _ in
            guard let textField = alertController.textFields?.first else { return }
            completion?(textField.text)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        alertController.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = NSLocalizedString("search", comment: "")
        })
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}
