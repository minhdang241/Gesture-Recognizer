//
//  DocumentStore.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/28/21.
//

import Foundation

struct DocumentStore {
    var directories: [String]
    
    mutating func addDirectory(name: String) {
        directories.append(name)
    }
}
