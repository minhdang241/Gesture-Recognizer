//
//  DrawingCanvas.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/22/21.
//

import SwiftUI
import PencilKit

struct DrawingCanvas: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    
    let ink = PKInkingTool(.pen, color: .black, width: 30)
    

    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.isOpaque = true
        canvas.backgroundColor = .white
        canvas.tool = ink
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        
    }
    
}
