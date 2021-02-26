//
//  Extension+UICollectionViewCell.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    @objc class var identifier: String {
        return String(describing: self)
    }
    
    @objc static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
