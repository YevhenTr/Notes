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

    private var model: RLMNote?
    
    //  MARK: Class methods

    static func create(with model: RLMNote) -> NoteViewController {
        let controller = NoteViewController.loadFromStoryboard()
        controller.model = model
        
        return controller
    }
    
    //  MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDone))
        self.rootView?.setupView(model: self.model)
    }
    
    @objc private func onDone(_ sender: UIBarButtonItem) {
        //  TODO: save note to realm
        self.navigationController?.popViewController(animated: true)
    }
}
