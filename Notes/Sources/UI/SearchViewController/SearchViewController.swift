//
//  SearchViewController.swift
//  Notes
//
//  Created by Evhenyi Triukhan on 7/24/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, RootViewGettable, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Subtypes

    private enum Constants {
        static var cellID = "Cell"
    }

    typealias RootView = SearchView

    // MARK: - Properties

    var folderName = ""
    var hostController: NotesTableViewController?

    private let storage = NoteStorage()
    private var model = [RLMNote]() {
        didSet { DispatchQueue.main.async { self.rootView?.tableView?.reloadData() } }
    }

    // MARK: - Public API

    @IBAction func onDone(_ sender: UIBarButtonItem) {
        self.rootView?.endEditing(true)
        self.dismiss(animated: true)
    }
    @IBAction func onStart(_ sender: UIButton) {
        guard let string = self.rootView?.searchTextField?.text else { return }

        self.storage.findNotes(with: string, in: self.folderName).do { self.model = $0 }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath)

        cell.textLabel?.text = model[indexPath.row].content.prefix(50).toString()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NoteViewController.create(with: self.model[indexPath.row])

        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true) {
            self.hostController?.navigationController?.pushViewController(controller, animated: true)
        }
    }

}
