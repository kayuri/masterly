//
//  FeedItem+JSON.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/14/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation
import UIKit

extension FeedItem {
    static func fromJson(_ data: [String: Any]) -> FeedItem? {
        
        guard let title = data["title"] as? String else {
            return .none
        }
        
        guard let posterPath = data["poster_path"] as? String else {
            return .none
        }
        
        return FeedItem(title: title, posterPath: posterPath)
    }
}
