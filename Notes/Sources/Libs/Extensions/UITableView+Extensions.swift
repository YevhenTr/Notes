//
//  UITableView+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/3/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<Cell: UITableViewCell>(_ cell: Cell.Type) {
        self.register(UINib(cell), forCellReuseIdentifier: cell.className)
    }
    
    func reusableCell<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath, _ configure: ((Cell) ->())? = nil) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: cell.className, for: indexPath)
        
        if let cell = cell as? Cell {
            configure?(cell)
        }
        
        return cell
    }
}


