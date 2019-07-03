//
//  UINib+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UINib {
    
    public convenience init<View: UIView>(_ viewClass: View.Type, bundle: Bundle? = nil) {
        self.init(nibName: viewClass.className, bundle: bundle)
    }
}
