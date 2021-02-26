//
//  Scheduler.swift
//  NYTimes
//
//  Created by marc helou on 2/17/21.
//  Copyright © 2021 marc helou. All rights reserved.
//

import Foundation

final class Scheduler {

    static var backgroundWorkScheduler: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let mainScheduler = RunLoop.main

}
