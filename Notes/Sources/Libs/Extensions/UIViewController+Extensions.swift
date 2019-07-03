//
//  UIViewController+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?,
                   message: String?,
                   preferredStyle: UIAlertController.Style = .alert,
                   actions: [UIAlertAction]? = [UIAlertAction(title: "OK", style: .default, handler: nil)])
    {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        actions?.forEach { alertController.addAction($0) }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String? ,
                   message: String?,
                   actionTitle: String?,
                   action: ((UIAlertAction) -> Void)?)
    {
        let alertAction = UIAlertAction(title: actionTitle, style: .default, handler: action)
        
        self.showAlert(title: title, message: message, actions: [alertAction])
    }
    
    func showActionSheet(title: String? = nil,
                         message: String? = nil,
                         actions: [UIAlertAction]? = nil)
    {
        self.showAlert(title: title,
                       message: message,
                       preferredStyle: .actionSheet,
                       actions: actions)
    }
}
