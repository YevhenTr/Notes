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
    
    func loadNotes(with folderName: String) -> [RLMNote]? {
        return self.readObjects(where: NSPredicate(format: "folder == %@", folderName))
    }
    
    func save(note: RLMNote) {
        self.save(object: note)
    }
    
    func delete(note: RLMNote) {
        self.deleteObject(id: note.id.description, type: RLMNote.self)
    }

    func findNotes(with string: String, in folder: String) -> [RLMNote]? {
        return self.readObjects(where: NSPredicate(format: "folder = %@ AND content contains[c] %@", folder, string))
    }
}

