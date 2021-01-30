//
//  GestureDocumentView.swift
//  gesture_generator (iOS)
//
//  Created by Minh Dang on 1/27/21.
//

import SwiftUI
import PencilKit
import Zip
import MessageUI // for sending email

struct GestureDocumentView: View {
    @State private var canvas: PKCanvasView = PKCanvasView()
    @State private var isShowingAlert = false
    @ObservedObject var gestureDocument: GestureDocument
    
    var body: some View {
        VStack {
            Text("Draw: \(gestureDocument.value)")
                .font(.title2)
                .padding(.top)
            
            Divider()
            
            DrawingCanvas(canvas: $canvas)
                .frame(height: 300)
            
            Divider()
            
            HStack(alignment: .center, spacing: 50) {
                CustomButton(title: "Save", color: Color.green, action: saveImage)
                CustomButton(title: "Clear", color: Color.red) { clearCanvas(canvas)}
                CustomButton(title: "Zip", color: Color.green, action: shareFile)
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle("Gesture Generator", displayMode: .inline)
        .navigationBarItems(trailing:
                                NavigationLink(
                                    destination: GestureDocumentStoreView(),
                                    label: {
                                        Image.init(systemName: "folder")
                                    })
        )
        
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Cannot save blank image"), message: Text("Please draw an image"), dismissButton: .default(Text("OK")))
        }
        
    }
    
    
    func shareFile() {
        let fileManager = FileManager.default
        
        let rootURL = try? fileManager.url(
            for: FileManager.SearchPathDirectory.documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        
        if rootURL != nil {
            let url: URL? = rootURL?.appendingPathComponent("TrainingData")
            let zipFile: URL? = try? Zip.quickZipFiles([url!], fileName: "TrainingData")
            let av = UIActivityViewController(activityItems: [zipFile!], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
            
        }
    }
    
    func clearCanvas(_ canvas: PKCanvasView) {
        canvas.drawing = PKDrawing()
    }
    
    func saveImage() {
        // 1: Save the image
        // 2: Reset the canvas
        
        // Get the path to the document directory in the app's sandbox
        if canvas.drawing.strokes.count == 0 {
            isShowingAlert = true
            return
        }
        do {
            let url = try FileManager.default.url(
                for: FileManager.SearchPathDirectory.documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let directoryURL = url.appendingPathComponent("TrainingData/\(gestureDocument.value)", isDirectory: true)
            if !FileManager.default.fileExists(atPath: "\(directoryURL)") {
                try? FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
            }
            
            var savedURL = directoryURL
            savedURL.appendPathComponent("\(gestureDocument.value)_\(String(describing: gestureDocument.getId()))")
            savedURL.appendPathExtension("jpeg")
            let data = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0).jpegData(compressionQuality: 1.0) ?? Data()
            do {
                try data.write(to: savedURL)
            } catch {
                print("Could not save the document with value \(gestureDocument.value)")
            }
            print("\(savedURL)")
            // Reset the drawing canvas
            canvas.drawing = PKDrawing()
            gestureDocument.generateNewDocument()
        } catch {
            print("Could get the path to the directory")
        }
    }
}

struct CustomButton: View {
    var title: String
    var color: Color
    var action: () -> Void
    var body: some View {
        Button(title) { action() }
            .font(.title3)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
