//
//  NoteViewController.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, StoryboardLoadable, RootViewGettable {
    
    //  MARK: - Subtypes

    typealias RootView = NoteView
    
    //  MARK: - Properties

    private var model: RLMNote?
    private let storage = NoteStorage()
    private let folderStorage = FolderStorage()
    
    //  MARK: - Class methods

    static func create(with model: RLMNote) -> NoteViewController {
        let controller = NoteViewController.loadFromStoryboard()
        controller.model = model
        
        return controller
    }
    
    //  MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    //  MARK: - Private API
    
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onDone))
        self.rootView?.setupView(model: self.model)
    }
    
    @objc private func onDone(_ sender: UIBarButtonItem) {
        self.createNote().do { self.folderStorage.add(note: $0) }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createNote() -> RLMNote? {
        guard
            let content = self.rootView?.contentTextView?.text,
            let folder = self.model?.folder
        else { return nil }
        
        return RLMNote(content: content, folder: folder)
    }
}
