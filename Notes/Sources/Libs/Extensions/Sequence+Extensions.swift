//
//  Sequence+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Sequence {
    
    public var array: [Element] {
        return self.map { $0 }
    }
    
    func asArray() -> [Element] {
        return self.map { $0 }
    }
}
