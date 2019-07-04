//
//  BaseTableView.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class BaseTableView: NibDesignable {
    
    @IBOutlet var itemsTableView: UITableView?
    @IBOutlet var addItemButton: UIBarButtonItem?
    
    var addAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onNewFolder(_ sender: UIBarButtonItem) {
        self.addAction?()
    }
}
