//
//  FeedItem.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/14/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation

class FeedItem {
    let title: String
    let posterPath: String
    
    init(title: String, posterPath: String) {
        self.title = title
        self.posterPath = posterPath
    }
}
