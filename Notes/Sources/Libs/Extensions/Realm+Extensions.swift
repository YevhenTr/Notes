//
//  Realm+Extensions.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/4/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    private struct Path {
        static let project = "/Users/student/Documents/Weather/Weather"
        static let filename = "/default.realm"
        static let realm = Path.project + "/Realm" + Path.filename
        
    }
    
    public static var projectFolderConfiguration: Realm.Configuration {
        return Configuration(fileURL: URL(string: Path.realm))
    }
    
    private struct Key {
        static let realmThread = "com.thread.realm.weather"
    }
    
    public static var current: Realm? {
        let key = Key.realmThread
        let thread = Thread.current
        
        return thread.threadDictionary[key]
            .flatMap { $0 as? WeakBox<Realm> }
            .flatMap { $0.wrapped }
            ?? {
                (try? Realm()).map {
                    thread.threadDictionary[key] = WeakBox($0)
                   
                    return $0
                }
//                    side { thread.threadDictionary[key] = WeakBox($0) }
                
        }()
    }
    
    public static func writeOperation(_ action: (Realm) -> ()) {
        self.current.do { $0.writeOperation(action) }
    }
    
    public func writeOperation(_ action: (Realm) -> ()) {
        if self.isInWriteTransaction {
            action(self)
        } else {
            try? self.write { action(self) }
        }
    }
}
