//
//  PopularViewController.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/14/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import UIKit

class PopularViewController: FeedViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        restApiService.fetchPopular { [weak self] (items, error) in
            if let error = error  {
                showErrorAlert(error: error, parent: self)
                return
            }
            
            guard let items = items else {
                return
            }
            self?.items = items
        }
    }
}
