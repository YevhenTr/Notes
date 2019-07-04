//
//  FoldersViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FoldersViewController: UIViewController, StoryboardLoadable, RootViewGettable {
    
    //  MARK: Subtypes
    
    typealias RootView = FoldersView
    
    //  MARK: Properties
    
    private var folders = [Folder(name: "Name1"), Folder(name: "Name2")]
    
    
    //  MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: Actions
    
    @IBAction func onNewFolder(_ sender: UIBarButtonItem) {
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { [weak self] _ in
            let id = (self?.folders.count ?? 0) + 1
            self?.folders.append(Folder(name: "Name\(id)"))
            self?.rootView?.foldersTableView?.insertRows(at: [IndexPath(row: id - 1, section: 0)], with: .left)
//            self?.rootView?.foldersTableView?.reloadData()
        }
//        let onCloud = UIAlertAction(title: "Cloud", style: .default, handler: nil)
        let actions: [UIAlertAction]? = [onPhone, cancel]
        
        self.showActionSheet(title: "New folder", message: "Where would you like to add this folder?", actions: actions)
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        let table = self.rootView?.foldersTableView
        table?.register(FolderTableViewCell.self)
        table?.delegate = self
        table?.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        self.rootView?.foldersTableView?.setEditing(editing, animated: animated)
        self.rootView?.newFolderButton?.isEnabled = !editing
    }
}

//  MARK: UITableViewDelegate, UITableViewDataSource

extension FoldersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: FolderTableViewCell.className, for: indexPath)
        
        cell.textLabel?.text = self.folders[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.folders.remove(at: indexPath.row)
            self.rootView?.foldersTableView?.deleteRows(at: [indexPath], with: .left)
        default:
            break
        }
    }
}
