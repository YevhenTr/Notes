//
//  FolderStorage.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import RealmSwift

class FolderStarage: BaseStorageRealm, FolderStorageProtocol {
    func loadAllFolders() -> [Folder]? {
        return self.readObjects(type: RLMFolder.self)?
            .asArray()
            .map { $0.asFolder() }
            .sorted(by: { $0.timestamp < $1.timestamp})
    }
    
    func loadFolder(name: String) -> Folder? {
        return (self.readObject(id: name) as? RLMFolder)?.asFolder()
    }
    
    func save(folder: Folder) {
        self.save(object: folder.asRealmObject())
    }
    
    func delete(folder: Folder) {
        self.deleteObject(id: folder.name)
    }
}
