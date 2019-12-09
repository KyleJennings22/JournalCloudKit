//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Kyle Jennings on 12/9/19.
//  Copyright © 2019 Kyle Jennings. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - Properties
    var entryLanding: Entry? {
        didSet {
            self.updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
            let body = bodyTextView.text,
            !title.isEmpty,
            !body.isEmpty
            else {return}
        if entryLanding == nil {
            EntryController.shared.saveEntry(title: title, body: body) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func updateViews() {
        DispatchQueue.main.async {
            guard let entry = self.entryLanding
                else {return}
            self.titleTextField.text = entry.title
            self.bodyTextView.text = entry.body
        }
    }
}
