//
//  ImageService.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/15/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import UIKit

let imageService = ImageService()

class ImageService {
    
    let session = URLSession(configuration: .default)
    
    fileprivate init() {
    }
    
    func fetchImage(_ imagePath: String, _ completion: @escaping (UIImage?, Error?) -> Void) {
        if let imageUrl = URL(string: "\(imageEndpoint)\(imagePath)") {
            
            if let image = imageCacheService.getImage(name: imagePath) {
                completion(image, .none)
                return
            }
            
            session.dataTask(with: imageUrl,
                             completionHandler: { (data, _, error) in
                                
                                if let error = error {
                                    completion(.none, error)
                                }
                                
                                if let image = UIImage(data: data!) {
                                    imageCacheService.cache(name: imagePath, image: image)
                                    completion(image, error)
                                }
            }).resume()
        }
    }
}
