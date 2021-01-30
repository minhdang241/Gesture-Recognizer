//
//  GestureGenerator.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/27/21.
//

import SwiftUI

class GestureDocument: ObservableObject {
    
    @Published private var document: Document
    
    init() {
        self.document = Document(value: Document.defaultValues[Int.random(in: 0..<Document.defaultValues.count)])
        
    }
    
    var value: String {
        return document.value
    }
    func generateNewDocument() -> Void {
        let length = Document.defaultValues.count
        let index = Int(arc4random_uniform(UInt32(length)))
        document = Document(value: Document.defaultValues[index])
    }
    
    func getId() -> UUID {
        return document.id
    }
}
