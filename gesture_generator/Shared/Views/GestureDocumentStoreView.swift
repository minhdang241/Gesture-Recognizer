//
//  GestureDocumentStore.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/28/21.
//

import SwiftUI

struct GestureDocumentStoreView: View {
    var documents: [String]? = GestureDocumentStore.getDirectories()
    
    var body: some View {
        List {
            ForEach(documents!, id: \.self) { name in
                NavigationLink(
                    destination: GestureDocumentStoreFolderView(folderName: name),
                    label: {
                        Text(name)
                    })
            }
        }
        .navigationBarTitle("FOLDERS")
    }
}


