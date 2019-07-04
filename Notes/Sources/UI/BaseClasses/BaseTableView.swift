//
//  BaseTableView.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class BaseTableView: NibDesignable {
    
    //  MARK: Properties
    
    @IBOutlet var mainTableView: UITableView?
    @IBOutlet var addButton: UIBarButtonItem?
    
    var addAction: (() -> ())?
    
    //  MARK: Public API
    
    @IBAction func onAddButton(_ sender: UIBarButtonItem) {
        self.addAction?()
    }
}
