//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NotesTableViewController: BaseTableViewController<Note, NoteTableViewCell> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addAction = { [weak self] in
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { _ in
                let id = (self?.model.count ?? 0) + 1
                self?.model.append(Note(content: "content\(id)"))
                self?.rootView?.itemsTableView?.insertRows(at: [IndexPath(row: id - 1, section: 0)], with: .left)
            }
            //        let onCloud = UIAlertAction(title: "Cloud", style: .default, handler: nil)
            let actions: [UIAlertAction]? = [onPhone, cancel]
            
            self?.showActionSheet(title: "New folder", message: "Where would you like to add this folder?", actions: actions)
        }
        
        self.selectAction = { [weak self] note in
            print(note.content + " " + note.timestamp.description)
        }
    }
}
