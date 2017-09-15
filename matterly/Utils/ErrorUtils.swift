//
//  ErrorExtension.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/14/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation
import UIKit

extension NSError {
    static func message(_ message: String, code: Int) -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: message]
        
        return NSError(domain: "com.exyte.matterly", code: code, userInfo: userInfo)
    }
}
