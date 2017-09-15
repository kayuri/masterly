//
//  DateUtils.swift
//  matterly
//
//  Created by Yuriy Kashnikov on 9/15/17.
//  Copyright © 2017 Exyte. All rights reserved.
//

import Foundation

func today() -> String {
    let date = Date()
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    return String(format:"%d-%d-%d", year, month, day)
}

func monthAgo() -> String? {
    let calendar = Calendar.current
    guard let date = Calendar.current.date(byAdding: .month, value: -1, to: Date()) else {
        return .none
    }
    let year = calendar.component(.year, from: date)
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    return String(format:"%d-%d-%d", year, month, day)
}
