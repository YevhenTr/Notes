//
//  FolderStorageProtocol.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

protocol FolderStorageProtocol {
    
    func loadAllFolders() -> [RLMFolder]?
    func loadFolder(name: String) -> RLMFolder?
    
    func save(folder: RLMFolder)
    func delete(folder: RLMFolder)
}
