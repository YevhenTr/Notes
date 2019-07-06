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
    
    static func create(with model: [Model]? = nil) -> Self {
        let controller = self.init()
        model.do { controller.model = $0 }
        
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
        
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.className, for: indexPath)
        (cell as? Cell).do { $0.configure(with: self.model[indexPath.row]) }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.model.remove(at: indexPath.row)
            self.rootView?.mainTableView?.deleteRows(at: [indexPath], with: .left)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectAction?(self.model[indexPath.row])
    }
}
