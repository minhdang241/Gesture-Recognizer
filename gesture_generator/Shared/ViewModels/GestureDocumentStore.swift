//
//  GestureDocumentStore.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/28/21.
//

import Foundation

class GestureDocumentStore: ObservableObject {
    
    init() {}
    
    static let rootURL: URL? = try? FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    //    static func appendPath(path: String) {
    //        currentURL = currentURL?.appendingPathComponent(path)
    //    }
    //
    //    static func truncatePath() {
    //        currentURL = currentURL?.deletingLastPathComponent()
    //    }
    
    static func getDirectories(at path: String? = nil) -> [String]? {
        let fileManager = FileManager.default
        var url: URL? = rootURL
        if path != nil {
            url = url?.appendingPathComponent(path!)
        }
        var dirURLs = try? fileManager.contentsOfDirectory(at: url!, includingPropertiesForKeys: nil, options: [])
        dirURLs = dirURLs?.filter{ $0.hasDirectoryPath}
        let dirNames = dirURLs?.map { $0.lastPathComponent }
        return dirNames
    }
    
    static func getFiles(at path: String? = nil) -> [String]? {
        let fileManager = FileManager.default
        var url: URL? = rootURL
        if path != nil {
            url = url?.appendingPathComponent(path!)
        }
        let dirURLs = try? fileManager.contentsOfDirectory(at: url!, includingPropertiesForKeys: nil, options: [])
        let dirNames = dirURLs?.map { $0.lastPathComponent }
        return dirNames
    }
}
