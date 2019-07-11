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
    @IBOutlet var countLabel: UILabel?
}

extension FolderTableViewCell: Configurable {
    
    func configure(with model: Any) {
        if let model = model as? RLMFolder {
            self.nameLabel?.text = model.name
            self.countLabel?.text = model.notes.count.description
        }
    }
}
