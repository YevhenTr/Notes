//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    
}

extension NoteTableViewCell: Configurable {
    
    func configure(with model: Any) {
        if let model = model as? Note {
            self.textLabel?.text = model.content
            self.detailTextLabel?.text = model.timestamp.description
        }
    }
}
