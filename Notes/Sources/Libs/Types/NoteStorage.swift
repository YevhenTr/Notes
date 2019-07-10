//
//  NoteStorage.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/9/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

import Foundation

class NoteStorage: BaseStorageRealm, NoteStorageProtocol {
    
    func loadAllNotes() -> [RLMNote]? {
        return self.readObjects(type: RLMNote.self)?
            .sorted(by: { $0.timestamp < $1.timestamp})
    }
    
    func loadNote(id: String) -> RLMNote? {
        return (self.readObject(id: id) as? RLMNote)
    }
    
    func loadNotes(folderName: String) -> [RLMNote]? {
        return self.readObjects(where: NSPredicate(format: "folder == %@", folderName))
    }
    
    func save(note: RLMNote) {
        self.save(object: note)
    }
    
    func delete(note: RLMNote) {
        self.deleteObject(id: note.id.description, type: RLMNote.self)
    }
}

//class BaseItemStorage<Item: Identifiable>: BaseStorageRealm {
//
//    func loadAllItems() -> [Item]? {
//        return self.readObjects(type: Item.self)?
//            .asArray()
//            .map { $0.asFolder() }
//            .sorted(by: { $0.timestamp < $1.timestamp})
//    }
//
//    func loadFolder(name: String) -> Folder? {
//        return (self.readObject(id: name) as? RLMFolder)?.asFolder()
//    }
//
//    func save(folder: Folder) {
//        self.save(object: folder.asRealmObject())
//    }
//
//    func delete(folder: Folder) {
//        self.deleteObject(id: folder.name)
//    }
//}

