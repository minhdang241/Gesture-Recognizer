//
//  HomeView.swift
//  gesture_generator
//
//  Created by Minh Dang on 1/29/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {}, label: {
                    NavigationLink(
                        destination: GestureRecognitionView(),
                        label: {
                            Text("Gesture Classifier")
                        })
                }).padding(.bottom)
                Button(action: {}, label: {
                    NavigationLink(
                        destination: GestureDocumentView(gestureDocument: GestureDocument()),
                        label: {
                            Text("Gesture Generator")
                        })
                })
            }
        }
    }
}
