//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    //  MARK: - Properties
    
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var contentTextView: TouchableTextView?
    
    //  MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    //  MARK: - Private API
    
    private func setupUI() {
        self.contentTextView?.textContainerInset = .zero
        self.contentTextView?.textContainer.lineFragmentPadding = 0
    }
}

extension NoteTableViewCell: Configurable {
    
    func configure(with model: Any) {
        if let model = model as? RLMNote {
            self.dateLabel?.text = model.timestamp.description
            self.contentTextView?.text = model.content
        }
    }
}
