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
            self?.selectAction?(Note(content: ""))
        }
        
        self.selectAction = { [weak self] note in
            print(note.content + " " + note.timestamp.description)
            let controller = NoteViewController.create(with: note)
            
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
