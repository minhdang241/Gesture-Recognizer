//
//  GestureDocumentStoreFileView.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/28/21.
//

import SwiftUI

import SwiftUI

struct GestureDocumentStoreFileView: View {
    @EnvironmentObject var gestureDocumentStore: GestureDocumentStore
    var documents: [String]?
    var data = [Data?]()
    init(folderName: String) {
        documents = GestureDocumentStore.getFiles(at: folderName)
        if let documents = self.documents {
            for index in 0..<documents.count {
                let filePath: URL? = GestureDocumentStore.rootURL?.appendingPathComponent("\(folderName)/\(documents[index])")

                data.append(try? Data.init(contentsOf: filePath!))
            }
        }
    }
    
    @ViewBuilder
    var body: some View {
        Group {
            if let documents = self.documents {
                List {
                    ForEach(0..<documents.count) { index in
                        HStack {
                            selectImage(data: data[index])
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                            Text(documents[index])
                        }
                    }
                }
            } else {
                Text("Empty")
            }
        }
        .navigationBarTitle("FILES")
    }
    
    func selectImage(data: Data?) -> Image {
        return Image(uiImage: UIImage(data: data ?? Data()) ?? UIImage())
    }
}

