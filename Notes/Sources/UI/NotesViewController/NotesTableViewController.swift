//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NotesTableViewController: BaseTableViewController<Note, NoteTableViewCell> {
    
    //  MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.addButton?.title = "New Note"
        
        self.addAction = { [weak self] in
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { [weak self] _ in
                guard let count = self?.model.count else { return }
                
                self?.model.append(Note(content: "Note\(count)"))
                self?.rootView?.mainTableView?.insertRows(at: [IndexPath(row: count, section: 0)], with: .left)
            }
            
            self?.showActionSheet(title: "New note", message: "Where would you like to add this note?", actions: [onPhone, cancel])
        }
        
        self.selectAction = { [weak self] note in
            print(note.content + " " + note.timestamp.description)
        }
    }
}
