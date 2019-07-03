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
    
    private let folders = [Folder(name: "Name1"), Folder(name: "Name2")]
    
    
    //  MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: Actions
    
    @IBAction func onNewFolder(_ sender: UIBarButtonItem) {
        
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        let table = self.rootView?.foldersTableView
        table?.register(FolderTableViewCell.self)
        table?.delegate = self
        table?.dataSource = self
        
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
}
