//
//  RealmConvertible.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/9/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

protocol RealmConvertible {
    
    associatedtype RealmObject: RLMObject
    
    func asRealmObject() -> RealmObject
}
