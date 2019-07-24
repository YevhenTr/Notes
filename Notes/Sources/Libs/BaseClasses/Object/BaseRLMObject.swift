//
//  BaseRLMObject.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers public class BaseRLMObject: Object, Identifiable {
    
    //  MARK: - Subtypes

    public enum Property: String {
        case id
    }
    
    //  MARK: - Properties

    public dynamic var id: String = ""
    
    //  MARK: - Class methods

    public override class func primaryKey() -> String? {
        return Property.id.rawValue
    }
    
    //  MARK: - Init and Deinit

    convenience init(id: String) {
        self.init()
        
        self.id = id
    }
}
