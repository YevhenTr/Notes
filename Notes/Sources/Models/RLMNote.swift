//
//  RLMNote.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/9/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RLMNote: BaseRLMObject {
    
    //  MARK: - Subtypes
    
    enum Property: String {
        case content
        case timestame
    }
    
    //  MARK: - Properties
    
    public dynamic var content: String = ""
    public var timestamp: Date = Date()
    
    //  MARK: - Init and Deinit
    
    convenience init(content: String, timestamp: Date = Date()) {
        self.init(id: timestamp.description)
        
        self.content = content
        self.timestamp = timestamp
    }
}
