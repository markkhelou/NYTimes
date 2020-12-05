//
//  File.swift
//  NYTimes
//
//  Created by marc helou on 12/4/20.
//  Copyright © 2020 marc helou. All rights reserved.
//

import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

class ImageViewFromURL: UIImageView {
    var imageURLString: String?
    
    func loadImage(_ urlString: String) {
        imageURLString = urlString
        
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                self.image = imageToCache
            }
        })
        
        task.resume()
    }
}
