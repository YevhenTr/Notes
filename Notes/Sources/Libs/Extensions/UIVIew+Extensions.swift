//
//  UIVIew+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UIView {
    
    static var className: String {
        return String(describing: self)
    }
}
