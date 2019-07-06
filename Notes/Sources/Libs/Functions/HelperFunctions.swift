//
//  HelperFunctions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

//  take value type
//  make copy
//  transform copy
//  return transformed copy
public func side<Value>(_ value: Value, action: @escaping (inout Value) -> ()) -> Value {
    var newValue = value  //  expected value type
    action(&newValue)
    
    return newValue
}

public func side<Value>(action: @escaping (inout Value) -> ()) -> (Value) -> (Value) {
    
    return { side($0, action: action) }
}
