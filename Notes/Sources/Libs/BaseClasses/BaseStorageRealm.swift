//
//  BaseStorageRealm.swift
//  Weather
//
//  Created by Yevhen Triukhan on 2/19/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import RealmSwift

class BaseStorageRealm: StorageProtocol {
    
    public typealias Invalidatable = NotificationToken
    public typealias RealmObject = RealmSwift.Object
    public typealias Value = RealmObject
    
    private let realm: Realm?
    public var tokens: [NotificationToken?] = []
    
    // MARK: - Initialization
    deinit { self.tokens.forEach { $0?.invalidate() } }
    
    init(realm: Realm? = Realm.current) {
        self.realm = realm
    }
    
    // MARK: - Storage Protocol
    //  create/update
    public func save<T: RealmObject>(object: T)  {
        return self.save(objects: [object])
    }
    
    public func save<T: RealmObject>(objects: [T]) {
        self.realm?.writeOperation {
            $0.add(objects, update: true)
        }
    }
    
    public func update<T: RealmObject>(object: T, action: (T) -> ()) {
        self.realm?.writeOperation { _ in
            action(object)
        }
    }
    
    //  read
    public func readObject<T: RealmObject>(id: String) -> T? {
        return self.realm?.object(ofType: T.self, forPrimaryKey: id)
    }
    
    public func readObjects<T: RealmObject>(type: T.Type) -> [T]? {
        return self.realm?.objects(T.self).array
    }
    
    public func readObject<T: RealmObject>(where: NSPredicate) -> T? {
        return nil
    }
    
    //  delete
    public func deleteObject<T: RealmObject>(id: String, type: T.Type) {
        self.realm?.writeOperation {
            if let object: T = self.readObject(id: id) {
                $0.delete(object)
            }
        }
    }
    
    public func deleteObjects<T: RealmObject>(type: T.Type) {
        self.realm?.writeOperation {
            $0.delete($0.objects(type))
        }
    }
    
    //  observing realm changes
    public func observe(_ block: @escaping NotificationBlock) -> Invalidatable? {
        return self.realm?.observe(block)
    }
    
    public func observe(_ block: @escaping (RealmCollectionChange<Results<RealmObject>>) -> Void) -> NotificationToken? {
        return self.realm?.objects(RealmObject.self).observe(block)
    }
}
