//
//  StorageProtocol.swift
//  Weather
//
//  Created by Yevhen Triukhan on 2/19/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

public protocol StorageProtocol {
    
    associatedtype Value
    
    //  CU
    func save(object: Value)
    
    func save(objects: [Value])
    
    //  R
    func readObject(id: String) -> Value?
    
    func readObjects(type: Value.Type) -> [Value]?
    
    //  D
    func deleteObject(id: String)
    
    func deleteObjects(type: Value.Type)
}
