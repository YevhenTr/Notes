//
//  SearchView.swift
//  Notes
//
//  Created by Evhenyi Triukhan on 7/24/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

class SearchView: UIView {

    // MARK: - Subtypes

    private enum Constants {
        static var bottomSpacing: CGFloat = 20
    }

    // MARK: - Properties

    @IBOutlet var tableView: UITableView?
    @IBOutlet var searchTextField: UITextField?
    @IBOutlet var bottomSpacing: NSLayoutConstraint?

    private let keyboardService = KeyboardNotificationsService()

    // MARK: - Init and Deinit

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupUI()
        self.setupKeyboardService()
    }

    // MARK: - Public API

    // MARK: - Private API

    private func setupUI() {
        self.searchTextField?.becomeFirstResponder()
    }

    private func setupKeyboardService() {
        self.keyboardService.handler = { keyboardParameters in
            let (state, keyboardFrame) = keyboardParameters
            let newSpacing = state == .show
                ? keyboardFrame.height + Constants.bottomSpacing
                : Constants.bottomSpacing

            self.setTable(spacing: newSpacing)
        }
    }

    private func setTable(spacing: CGFloat) {
        UIView.animate(withDuration: 2.5) {
            self.bottomSpacing?.constant = spacing
            self.layoutIfNeeded()
        }
    }
}
