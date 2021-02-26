//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import UIKit

/// A `Coordinator` takes responsibility about coordinating view controllers and driving the flow in the application.
protocol Coordinator: class {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: Coordinator? { get set }
    var rootViewController: UIViewController? { get set }
    
    /// Stars the flow
    func start()
    
}

class BaseCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    weak var parentCoordinator: Coordinator?
    weak var rootViewController: UIViewController?
    
    override init() {
        super.init()
        navigationController = UINavigationController()
        navigationController?.delegate = self
    }
    
    func start() { fatalError("Start method must be implemented") }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if fromViewController == self.rootViewController {
            didFinish()
        }
    }
    
    func didFinish() {
        if let index = self.parentCoordinator?.childCoordinators.firstIndex(where: { $0 === self }) {
            self.parentCoordinator?.childCoordinators.remove(at: index)
        }
    }
}
