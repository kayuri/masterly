//
//  ImageCacheService.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/15/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import UIKit

let imageCacheService = ImageCacheService()

class ImageCacheService {

    let imageCache = NSCache<NSString, UIImage>()

    fileprivate init () {
        
    }
    
    func cache(name: String, image: UIImage) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func getImage(name: String) -> UIImage? {
        if let image = imageCache.object(forKey: name as NSString) {
            return image
        }
        return .none
    }
}
