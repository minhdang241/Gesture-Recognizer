//
//  ImageDocument.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/27/21.
//

import Foundation

struct Document {
    var value: String
    var id: UUID = UUID()
    static var defaultValues: [String] = ["Smile", "X", "Heart", "Circle", "?"]
}


