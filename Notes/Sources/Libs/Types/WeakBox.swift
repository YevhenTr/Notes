//
//  WeakBox.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

class WeakBox<Wrapped: AnyObject>: Equatable {
    
    //  MARK: - Properties

    public var isEmpty: Bool { return self.wrapped.isNone }
    private(set) weak var wrapped: Wrapped?
    
    //  MARK: - Init and Deinit
    
    init(_ strongObject: Wrapped) {
        self.wrapped = strongObject
    }
    
    //  MARK: - Equatable
    
    static func == (lhs: WeakBox, rhs: WeakBox) -> Bool {
        if
            let lhs = lhs.wrapped,
            let rhs = rhs.wrapped {
            return lhs === rhs
        } else {
            return false
        }
    }
}
