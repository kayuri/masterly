//
//  AlertUtils.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/14/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation
import UIKit

func showErrorAlert(error: NSError, parent: UIViewController?) {
    let alert = UIAlertController(
        title: "Error",
        message: error.localizedDescription,
        preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: .none))
    
    parent?.present(alert, animated: true, completion: .none)
}
