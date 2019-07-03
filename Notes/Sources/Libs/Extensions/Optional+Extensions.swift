//
//  Optional+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Optional {
    
    func `do`(_ action:(Wrapped) -> ()) {
        self.map(action)
    }
}
