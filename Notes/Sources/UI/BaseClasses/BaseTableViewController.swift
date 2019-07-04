//
//  BaseTableViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class BaseTableViewController<Model, Cell: UITableViewCell & Configurable>: UIViewController, StoryboardLoadable, RootViewGettable, UITableViewDelegate, UITableViewDataSource {
    
    //  MARK: Subtypes
    
    typealias RootView = BaseTableView
    
    //  MARK: Properties
    
    var model = [Model]()
    var addAction: (() -> ())? {
        didSet {
            self.rootView?.addAction = self.addAction
        }
    }
    var selectAction: ((Model) -> ())?

    //  MARK: Class methods
    
    static func create(with model: [Model]) -> Self {
        let controller = self.init()
        controller.model = model
        
        return controller
    }
    
    //  MARK: View Lifecycle
    
    override func loadView() {
        self.view = BaseTableView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupAddAction()
    }
    
    //  MARK: Actions
    
    func setupAddAction() {
        //        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        //        let onPhone = UIAlertAction(title: "On My iPhone", style: .default) { [weak self] _ in
        //            let id = (self?.model.count ?? 0) + 1
        //            self?.model.append(Folder(name: "Name\(id)"))
        //            self?.rootView?.foldersTableView?.insertRows(at: [IndexPath(row: id - 1, section: 0)], with: .left)
        //            //            self?.rootView?.foldersTableView?.reloadData()
        //        }
        //        //        let onCloud = UIAlertAction(title: "Cloud", style: .default, handler: nil)
        //        let actions: [UIAlertAction]? = [onPhone, cancel]
        //
        //        self.showActionSheet(title: "New folder", message: "Where would you like to add this folder?", actions: actions)
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let table = self.rootView?.itemsTableView
        table?.register(Cell.self)
        table?.delegate = self
        table?.dataSource = self
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        
        self.rootView?.itemsTableView?.setEditing(editing, animated: animated)
        self.rootView?.addItemButton?.isEnabled = !editing
    }
    //}
    
    //  MARK: UITableViewDelegate, UITableViewDataSource
    
    //extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.className, for: indexPath)
        
        if let cell = cell as? Cell {
            cell.configure(with: self.model[indexPath.row])
        }
        //        cell.textLabel?.text = self.folders[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.model.remove(at: indexPath.row)
            self.rootView?.itemsTableView?.deleteRows(at: [indexPath], with: .left)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectAction?(self.model[indexPath.row])
//        self.navigationController?.pushViewController(NotesViewController.loadFromStoryboard(), animated: true)
    }
}
