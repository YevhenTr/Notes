//
//  FoldersViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FoldersViewController: BaseTableViewController<Folder, FolderTableViewCell> {
    
    //  MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Folders"
        self.rootView?.addButton?.title = "New Folder"
        
        self.addAction = { [weak self] in
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { [weak self] _ in
                guard let count = self?.model.count else { return }
                
                self?.model.append(Folder(name: "Folder\(count)"))
                self?.rootView?.mainTableView?.insertRows(at: [IndexPath(row: count, section: 0)], with: .left)
            }
            
            self?.showActionSheet(title: "New folder", message: "Where would you like to add this folder?", actions: [onPhone, cancel])
        }
        
        self.selectAction = { [weak self] folder in
            let controller = NotesTableViewController.create()
            
            controller.navigationItem.title = folder.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
