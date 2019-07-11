//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NotesTableViewController: BaseTableViewController<RLMNote, FolderStorage, NoteTableViewCell> {
    
    //  MARK: - Subtypes
    
    private struct Constants {
        static let defaultRowHeight: CGFloat = 110.0
    }
    
    typealias Strings = AppConstants.Notes
    
    //  MARK: - Properties
    
    override var model: [RLMNote]? {
        return self.storage?.loadFolder(name: self.folderName)?.notes.array.sorted(by: > )
    }
    
    private var folderName: String {
        return self.navigationItem.title ?? ""
    }
    
    //  MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //  MARK: - Public API
    
    override func setupUI() {
        super.setupUI()
        
        self.storage = FolderStorage()
        
        let rootView = self.rootView
        
        rootView?.mainTableView?.rowHeight = Constants.defaultRowHeight
        rootView?.addButton?.title = Strings.addButtonTitle
        
        self.addAction = { [weak self] in
            guard let folderName = self?.folderName else { return }
            let controller = NoteViewController.create(with: RLMNote(content: "", folder: folderName))
            self?.navigationController?.pushViewController(controller, animated: true)

        }
        
        self.selectAction = { [weak self] note in
            let controller = NoteViewController.create(with: note)
            
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
