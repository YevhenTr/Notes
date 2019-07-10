//
//  Date+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/9/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

extension Date {
    
    func asString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
