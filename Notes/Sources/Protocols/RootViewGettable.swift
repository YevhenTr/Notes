//
//  RootViewGettable.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

protocol RootViewGettable {
    
    associatedtype RootView = UIView
    
    var rootView: RootView? { get }
}

extension RootViewGettable where Self: UIViewController {
    
    var rootView: RootView? {
        guard let view = self.viewIfLoaded else { return nil }
        
        return  view as? RootView
    }
}
