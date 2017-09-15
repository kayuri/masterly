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


    fileprivate init() {
    }
    
    func fetchImage(_ imagePath: String, _ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let imageUrl = URL(string: "\(imageEndpoint)\(imagePath)") {
            let session = URLSession(configuration: .default)
            session.dataTask(with: imageUrl,
                             completionHandler: completion).resume()
        }
    }
}
