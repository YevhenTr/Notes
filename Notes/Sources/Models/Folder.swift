//
//  Folder.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

class Folder {
    
    //  MARK: Properties

    let name: String
    var notes: [Note]?
    
    //  MARK: Init and deinit
    
    init(name: String) {
        self.name = name
    }
}
