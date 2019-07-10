//
//  FoldersViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit
import RealmSwift

class FoldersViewController: BaseTableViewController<RLMFolder, FolderStorage, FolderTableViewCell> {
    
    //  MARK: - Subtypes
    
    typealias Strings = AppConstants.Folders
    
    //  MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //  MARK: - Private API
    
    override func setupUI() {
        super.setupUI()
        
        self.navigationItem.title = Strings.navigationTitle
        self.rootView?.addButton?.title = Strings.addButtonTitle
        
        self.addAction = { [weak self] in
            let cancel = UIAlertAction(title: AppConstants.cancel, style: .cancel)
            let onPhone = UIAlertAction(title: Strings.onPhone, style: .default) { _ in
                guard let count = self?.model?.count else { return }
                
                self?.createFolder(at: (IndexPath(row: count, section: 0)))
            }
            
            self?.showActionSheet(title: Strings.actionTitle,
                                  message: Strings.actionMessage,
                                  actions: [onPhone, cancel])
        }
        
        self.selectAction = { [weak self] folder in
            let controller = NotesTableViewController.create(storage: NoteStorage())
            
            controller.navigationItem.title = folder.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
        
        self.deleteAction = { [weak self] folder in
            self?.storage?.delete(folder: folder)
        }
    }
    
    private func createFolder(at indexPath: IndexPath) {
        self.requestFolderName() { [weak self] newFolderName in
            let isNameTaken = self?.model?.contains(where: { $0.name == newFolderName }) ?? true
            
            if isNameTaken {
                self?.showAlert(title: Strings.warningTitle, message: Strings.warningMessage)
            } else {
                let folder = RLMFolder(name: newFolderName)
                self?.storage?.save(folder: folder)
                self?.reloadData()
//                self?.rootView?.mainTableView?.insertRows(at: [indexPath], with: .left)
            }
        }
    }
    
    private func requestFolderName(completion: @escaping (String) -> ()) {
        let alertController = UIAlertController(title: Strings.alertTitle, message: Strings.alertMessage, preferredStyle: .alert)
        alertController.addTextField() { $0.placeholder = Strings.alertPlaceholder }

        let cancelAction = UIAlertAction(title: AppConstants.cancel, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: AppConstants.save, style: .default) { _ in
            alertController.textFields?.first?.text.do { completion($0) }
        }
        
        [cancelAction, okAction].forEach { alertController.addAction($0) }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
