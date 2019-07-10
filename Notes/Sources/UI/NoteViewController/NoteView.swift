//
//  NoteView.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoteView: UIView {
    
    //  MARK: - Subtypes
    
    typealias Strings = AppConstants.Note
    
    //  MARK: - Properties
    
    @IBOutlet var contentTextView: UITextView?
    @IBOutlet var headerLabel: UILabel?
    @IBOutlet var contentBottomConstraint: NSLayoutConstraint?
    
    private var keyboardService = KeyboardNotificationsService()
    private var defaultBottomSpacing: CGFloat = 0
    
    //  MARK: - Public API
    
    func setupView(model: RLMNote?) {
        guard let model = model else { return }
        let constraint = self.contentBottomConstraint
        let contentTextView = self.contentTextView

        //  setup header
        self.headerLabel?.text = model.timestamp.asString(format: Strings.timeFormat)
        
        //  setup textview size
        self.defaultBottomSpacing = constraint?.constant ?? 0
        let defaultSpacing = self.defaultBottomSpacing
        
        self.keyboardService.handler = { [weak self] parameters in
            let inset = parameters.frame.height
            let state = parameters.state
            
            if state == .hide && constraint?.constant != defaultSpacing {
                constraint?.constant = defaultSpacing
            } else if parameters.state == .show && constraint?.constant == defaultSpacing {
                constraint?.constant = inset
            }

            UIView.animate(withDuration: 1.0) { self?.layoutIfNeeded() }
        }
        
        //  setup textview content
        if model.content.isEmpty {
            contentTextView?.becomeFirstResponder()
        } else {
            contentTextView?.text = model.content
        }
    }
}

