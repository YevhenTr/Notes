//
//  FolderTableViewCell.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel?
}

extension FolderTableViewCell: Configurable {
    
    func configure(with model: Any) {
        if let model = model as? Folder {
            self.nameLabel?.text = model.name
        }
    }
}
