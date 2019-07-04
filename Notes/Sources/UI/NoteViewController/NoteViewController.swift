//
//  NoteViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, StoryboardLoadable, RootViewGettable {
    
    //  MARK: Subtypes

    typealias RootView = NoteView
    
    //  MARK: Properties

    private var model: Note?
    
    //  MARK: Class methods

    static func create(with model: Note) -> NoteViewController {
        let controller = NoteViewController.loadFromStoryboard()
        controller.model = model
        
        return controller
    }
    
    //  MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.rootView?.contentTextView?.becomeFirstResponder()
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDone))
    }
    
    @objc private func onDone(_ sender: UIBarButtonItem) {
        //  TODO: save note to realm
        self.navigationController?.popViewController(animated: true)
    }
}
