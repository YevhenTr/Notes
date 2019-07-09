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
    #warning("Constraints")
    func configure(with model: Any) {
        if let model = model as? RLMFolder {
            self.nameLabel?.text = model.name
        }
    }
}
