//
//  TouchableTextView.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/7/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class TouchableTextView: UITextView {
    
    //  MARK: - Init and Deinit
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    //  MARK: - Private API
    
    private func setupView() {
        self.isEditable = false
        self.isSelectable = false
        self.isUserInteractionEnabled = true
    }
    
    //  MARK: - Forwarding touches to superview
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview.do {
            $0.touchesBegan(touches, with: event)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview.do {
            $0.touchesEnded(touches, with: event)
        }
    }
}

