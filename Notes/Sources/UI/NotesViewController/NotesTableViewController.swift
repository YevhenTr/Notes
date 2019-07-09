//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NotesTableViewController: BaseTableViewController<RLMNote, NoteStorage, NoteTableViewCell> {
    
    //  MARK:  Subtypes
    
    private struct Constants {
        static let defaultRowHeight: CGFloat = 110.0
    }
    
    typealias Strings = AppConstants.Notes
    
    //  MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.model.append(Note(content: "content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content content "))
        self.rootView?.mainTableView?.reloadData()

        self.setupUI()
    }
    
    //  MARK: - Private API
    
    private func setupUI() {
        let rootView = self.rootView
        
        rootView?.mainTableView?.rowHeight = Constants.defaultRowHeight
        rootView?.addButton?.title = Strings.addButtonTitle
        
        self.addAction = { [weak self] in
            self?.selectAction?(RLMNote(content: "test test test test test test test test ", timestamp: Date()))
        }
        
        self.selectAction = { [weak self] note in
            let controller = NoteViewController.create(with: note)
            
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
