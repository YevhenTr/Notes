//
//  FolderStorageProtocol.swift
//  Notes
//
//  Created by Yevhen Triukhan on 7/8/19.
//  Copyright © 2019 Yevhen Triukhan. All rights reserved.
//

protocol FolderStorageProtocol {
    
    func loadAllFolders() -> [Folder]?
    func loadFolder(name: String) -> Folder?
    
    func save(folder: Folder)
    func delete(folder: Folder)
}

