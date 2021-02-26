//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 12/5/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

class BlurLoader: UIView {
    
    var blurEffectView: UIVisualEffectView?
    
    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.center.y -= 50
        activityIndicator.startAnimating()
    }
}

class LoadingHUD: NSObject {
    static var shared = LoadingHUD()
    
    private lazy var loaderView: UIView = {
        let view = BlurLoader(frame: UIScreen.main.bounds)
        return view
    }()
    
    func showLoader() {
        if #available(iOS 13.0, *) {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate {
                sceneDelegate.window?.addSubview(loaderView)
            }
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.addSubview(loaderView)
            }
        }
    }
    
    func hideLoader() {
        loaderView.removeFromSuperview()
    }
}
