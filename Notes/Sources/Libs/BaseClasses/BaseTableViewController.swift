//
//  BaseTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit
import RealmSwift

class BaseTableViewController<Model: RLMObject & Identifiable, Storage: BaseStorageRealm, Cell: UITableViewCell & Configurable>: UIViewController, StoryboardLoadable, RootViewGettable, UITableViewDelegate, UITableViewDataSource {
    
    //  MARK: Subtypes
    
    typealias RootView = BaseTableView
    
    //  MARK: Properties
    var storage: Storage?
    var model: [Model]? {
        get { return self.storage?.readObjects(type: Model.self) ?? nil }
    }
    var addAction: (() -> ())? {
        didSet {
            self.rootView?.addAction = self.addAction
        }
    }
    var selectAction: ((Model) -> ())?
    var deleteAction: ((Model) -> ())?

    //  MARK: Class methods
    
    static func create(storage: Storage) -> Self {
        let controller = self.init()
        controller.storage = storage
        
        return controller
    }
    
    //  MARK: View Lifecycle
    
    override func loadView() {
        self.view = BaseTableView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: Public API
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        self.rootView?.mainTableView?.setEditing(editing, animated: animated)
        self.rootView?.addButton?.isEnabled = !editing
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let table = self.rootView?.mainTableView
        table?.register(Cell.self)
        table?.delegate = self
        table?.dataSource = self
    }
    
    //  MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.className, for: indexPath)
        self.model?.objectAtIndex(indexPath.row).do { item in
            (cell as? Cell).do { $0.configure(with: item) }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.model?.objectAtIndex(indexPath.row).do { self.deleteAction?($0) }
//            self.rootView?.mainTableView?.deleteRows(at: [indexPath], with: .left)
            self.rootView?.mainTableView?.reloadData()
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.model?.objectAtIndex(indexPath.row).do { self.selectAction?($0) }
    }
}
