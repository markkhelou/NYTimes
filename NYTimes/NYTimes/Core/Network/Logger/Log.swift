//
//  Debugger.swift
//  APILayerProj
//
//  Created by marc helou on 2/20/21.
//

import Foundation

public func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}
