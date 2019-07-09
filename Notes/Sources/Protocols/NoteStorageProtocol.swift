//
//  NoteStorageProtocol.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/9/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

protocol NoteStorageProtocol {
    
    func loadAllNotes() -> [RLMNote]?
    func loadNote(id: String) -> RLMNote?
    
    func save(note: RLMNote)
    func delete(note: RLMNote)
}
