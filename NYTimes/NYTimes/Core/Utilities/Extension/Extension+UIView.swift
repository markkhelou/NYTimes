//
//  Extension+UIView.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

extension UIView {
    
    func maskCorners(_ radius: CGFloat = 3.0) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func circular() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}
