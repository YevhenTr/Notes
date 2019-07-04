//
//  FoldersViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FoldersViewController: BaseTableViewController<Folder, FolderTableViewCell> {
    
    override func setupAddAction() {
        super.setupAddAction()
        
        self.rootView?.addAction = { [weak self] in
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { [weak self] _ in
            let id = (self?.model.count ?? 0) + 1
            self?.model.append(Folder(name: "Name\(id)"))
            self?.rootView?.itemsTableView?.insertRows(at: [IndexPath(row: id - 1, section: 0)], with: .left)
            //            self?.rootView?.foldersTableView?.reloadData()
        }
        //        let onCloud = UIAlertAction(title: "Cloud", style: .default, handler: nil)
        let actions: [UIAlertAction]? = [onPhone, cancel]
        
        self?.showActionSheet(title: "New folder", message: "Where would you like to add this folder?", actions: actions)
        }
        
        self.selectAction = { [weak self] folder in
            let controller = NotesTableViewController.create(with: [Note(content: "content1"), Note(content: "content2")])
            //        let controller2 = BaseTableViewController<Note, NoteTableViewCell>.loadFromStoryboard()
            //        controller2.model = [Note(content: "content1"), Note(content: "content2")]
            //        let controller3 = NewBaseTableViewController.loadFromStoryboard()
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
