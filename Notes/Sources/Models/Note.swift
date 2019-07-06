//
//  Note.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

class Note: Hashable {
    
    //  MARK: Properties
    
    let content: String
    let timestamp: Date
    
    //  MARK: Init and deinit
    
    init(content: String) {
        self.content = content
        self.timestamp = Date()
    }
    
    //  MARK: - Equatable
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.timestamp == rhs.timestamp
    }
    
    //  MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(timestamp)
    }
}
