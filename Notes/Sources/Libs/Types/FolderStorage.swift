//
//  FolderStorage.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import RealmSwift

class FolderStorage: BaseStorageRealm, FolderStorageProtocol {
    
    func loadAllFolders() -> [RLMFolder]? {
        return self.readObjects(type: RLMFolder.self)?
            .sorted(by: { $0.timestamp < $1.timestamp})
    }
    
    func loadFolder(name: String) -> RLMFolder? {
        return self.readObject(id: name)
    }
    
    func save(folder: RLMFolder) {
        self.save(object: folder)
    }
    
    func add(note: RLMNote) {
        guard let folder = self.loadFolder(name: note.folder) else { return }
        
        self.update(object: folder) { folder in
            folder.notes.append(note)
        }
    }
    
    func delete(folder: RLMFolder) {
        self.deleteObject(id: folder.id, type: RLMFolder.self)
    }
}
