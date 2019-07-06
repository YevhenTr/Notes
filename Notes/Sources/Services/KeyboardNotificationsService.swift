//
//  KeyboardNotificationsService.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/6/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

enum KeyboardState {
    case show
    case hide
}

typealias KeyboardParameters = (state: KeyboardState, frame: CGRect)

final class KeyboardNotificationsService {
    
    // MARK: - Properties

    public var handler: ((KeyboardParameters) -> ())?

    private let notifications = [
        UIWindow.keyboardWillShowNotification,
        UIWindow.keyboardWillHideNotification,
    ]

    // MARK: - Initialization and Deallocation
    
    deinit {
        self.notifications.forEach {
            NotificationCenter.default.removeObserver(self, name: $0, object: nil)
        }
    }
    
    init() {
        self.notifications.forEach {
            NotificationCenter.default.addObserver(self, selector: #selector(showOrHideKeyboard), name: $0, object: nil)
        }
    }
    
    // MARK: - Private methods
    
    @objc private func showOrHideKeyboard(_ notification: Notification) {
        let state: KeyboardState = UIWindow.keyboardWillShowNotification == notification.name ? .show : .hide
        let frame = (notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect) ?? CGRect.zero

        self.handler?((state, frame))
    }
}
