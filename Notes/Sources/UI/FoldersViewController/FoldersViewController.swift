//
//  FoldersViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FoldersViewController: BaseTableViewController<Folder, FolderTableViewCell> {
    
    //  MARK: Subtypes
    
    typealias Strings = AppConstants.Folders
    
    //  MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        let rootView = self.rootView
        
        self.navigationItem.title = Strings.navigationTitle
        rootView?.addButton?.title = Strings.addButtonTitle
        
        self.addAction = { [weak self] in
            let cancel = UIAlertAction(title: AppConstants.cancel, style: .cancel)
            let onPhone = UIAlertAction(title: Strings.onPhone, style: .default) { _ in
                guard let count = self?.model.count else { return }
                
                self?.createFolder() { newFolder in
                    let isNameTaken = self?.model.contains(where: { $0.name == newFolder.name }) ?? true
                    
                    if isNameTaken {
                        self?.showAlert(title: Strings.warningTitle, message: Strings.warningMessage)
                    } else {
                        self?.model.append(newFolder)
                        rootView?.mainTableView?.insertRows(at: [IndexPath(row: count, section: 0)], with: .left)
                    }
                }
            }
            
            self?.showActionSheet(title: Strings.actionTitle,
                                  message: Strings.actionMessage,
                                  actions: [onPhone, cancel])
        }
        
        self.selectAction = { [weak self] folder in
            let controller = NotesTableViewController.create()
            
            controller.navigationItem.title = folder.name
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func createFolder(completion: @escaping (Folder) -> ()) {
        let alertController = UIAlertController(title: Strings.alertTitle, message: Strings.alertMessage, preferredStyle: .alert)
        alertController.addTextField() { $0.placeholder = Strings.alertPlaceholder }

        let cancelAction = UIAlertAction(title: AppConstants.cancel, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: AppConstants.save, style: .default) { _ in
            if let text = alertController.textFields?.first?.text {
                completion(Folder(name: text))
            }
        }
        
        [cancelAction, okAction].forEach { alertController.addAction($0) }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
