//
//  GestureDocumentStoreFolderView.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/28/21.
//

import SwiftUI

import SwiftUI

struct GestureDocumentStoreFolderView: View {
    
    var documents: [String]?
    var folderName: String
    init(folderName: String) {
        self.folderName = folderName
        documents = GestureDocumentStore.getDirectories(at: folderName)
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            if let documents = self.documents {
                List {
                    ForEach(documents, id: \.self) { name in
                        NavigationLink(
                            destination: GestureDocumentStoreFileView(folderName: "\(folderName)/\(name)"),
                            label: {
                                Text(name)
                            })
                    }
                }
            } else {
                Text("Empty")
            }
        }
        .navigationBarTitle("TYPE FOLDERS")
    }
}

