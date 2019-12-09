//
//  DateExtension.swift
//  JournalCloudKit
//
//  Created by Kyle Jennings on 12/9/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation

extension Date {
    
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: self)
    }
}
