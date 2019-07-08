//
//  RLMFolder.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation
import RealmSwift

typealias RLMObject = RealmSwift.Object

@objcMembers class RLMFolder: BaseRLMObject {
    
    //  MARK: - Subtypes
    
    enum Property: String {
        case name
        case timestame
    }
    
    //  MARK: - Properties
    
    public dynamic var name: String = ""
    public var timestamp: Date = Date()
    
    //  MARK: - Init and Deinit
    
    convenience init(name: String, timestamp: Date) {
        self.init(id: name)
        
        self.name = name
        self.timestamp = timestamp
    }
    
    //  MARK: - Public API
    
    func asFolder() -> Folder {
        return Folder(name: self.name, timestamp: self.timestamp)
    }
}
