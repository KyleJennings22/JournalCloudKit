//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Kyle Jennings on 12/9/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation
import CloudKit

class Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
    
    let title: String
    let body: String
    let timestamp: Date
    
    init(title: String, body: String, timestamp: Date = Date()) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
    }
}

extension CKRecord {
    convenience init(entry: Entry) {
        self.init(recordType: EntryKeys.RecordTypeKey)
        setValue(entry.title, forKey: EntryKeys.TitleKey)
        setValue(entry.body, forKey: EntryKeys.BodyKey)
        setValue(entry.timestamp, forKey: EntryKeys.TimestampKey)
    }
}

extension Entry {
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryKeys.TitleKey] as? String,
            let body = ckRecord[EntryKeys.BodyKey] as? String,
            let timestamp = ckRecord[EntryKeys.TimestampKey] as? Date
            else {return nil}
        self.init(title: title, body: body, timestamp: timestamp)
    }
}

enum EntryKeys {
    static let RecordTypeKey = "Entry"
    fileprivate static let TitleKey = "title"
    fileprivate static let BodyKey = "body"
    fileprivate static let TimestampKey = "timestamp"
}
