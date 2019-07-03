//
//  StoryboardLoadable.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

protocol StoryboardLoadable {
    
    static func loadFromStoryboard(_ name: String?) -> Self
}

extension StoryboardLoadable where Self: UIViewController {
    
    static func loadFromStoryboard(_ name: String? = nil) -> Self {
        let className = String(describing: Self.self)
        let storyboardName = name ?? className
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        let controller = storyboard.instantiateViewController(withIdentifier: className) as? Self ?? Self()
        
        return controller
    }
}
