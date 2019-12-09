//
//  EntryController.swift
//  JournalCloudKit
//
//  Created by Kyle Jennings on 12/9/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    static let shared = EntryController()
    var entries: [Entry] = []
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func saveEntry(title: String, body: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, body: body)
        let entryRecord = CKRecord(entry: entry)
        
        privateDB.save(entryRecord) { (record, error) in
            if let error = error {
                print("Error saving record to database:", error.localizedDescription)
                return completion(false)
            }
            self.entries.append(entry)
            return completion(true)
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void ) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: EntryKeys.RecordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error fetching entries:", error.localizedDescription)
                return completion(false)
            }
            guard let records = records else {return completion(false)}
            let entries = records.compactMap({ entry in
                Entry(ckRecord: entry)
            })
            self.entries = entries
            return completion(true)
        }
    }
}
