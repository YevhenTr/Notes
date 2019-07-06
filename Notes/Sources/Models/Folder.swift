//
//  Folder.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

class Folder: Hashable {
    
    //  MARK: Properties

    let name: String
    let timestamp: Date
    var notes: [Note]?
    
    //  MARK: Init and deinit
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
    }
    
    //  MARK: Equatable
    
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return lhs.timestamp == rhs.timestamp
    }
    
    //  MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.timestamp)
    }
}

