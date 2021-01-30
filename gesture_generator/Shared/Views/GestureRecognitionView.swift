//
//  GestureRecognitionView.swift
//  gesture_generator
//
//  Created by Minh Dang on 1/29/21.
//

import SwiftUI
import PencilKit

struct GestureRecognitionView: View {
    @State private var canvas: PKCanvasView = PKCanvasView()
    @State private var prediction: String = ""
    //    @State private var isShowingAlert = false
    //    @ObservedObject var gestureDocument: GestureDocument
    
    var body: some View {
        VStack {
            Text("Prediction: \(prediction)")
                .font(.title2)
                .padding(.top)
            
            Divider()
            
            DrawingCanvas(canvas: $canvas)
                .frame(height: 300)
            
            Divider()
            
            HStack(alignment: .center, spacing: 50) {
                CustomButton(title: "Clear", color: Color.red) { clearCanvas(canvas)}
                CustomButton(title: "Classify", color: Color.blue, action: classifyGesture)
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle("Gesture Generator", displayMode: .inline)
    }
    func clearCanvas(_ canvas: PKCanvasView) {
        canvas.drawing = PKDrawing()
    }
    
    func classifyGesture() {
        let model = GestureRecognizerModel()
        do {
            let rootUrl = try FileManager.default.url(
                for: FileManager.SearchPathDirectory.documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let fileURL = rootUrl.appendingPathComponent("TrainingData/Heart/Heart_20AC66EB-F90D-46F3-9A46-8C97D9A3CA8F.jpeg")
            //let data = try? Data.init(contentsOf: fileURL)
            let data = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1.0).jpegData(compressionQuality: 1.0) ?? Data()
            if data != nil {
                let img = UIImage(data: data)
                let resizedImg = img!.resizeTo(size: CGSize(width: 340, height: 340))
                guard let buffer = resizedImg.toBuffer() else { return }
                do {
                    let prediction = try? model.prediction(input_1: buffer)
                    if let output = prediction {
                        let classes: [String] = ["?","Circle","Heart","Smile","X"]
                        self.prediction = classes[Int(output.classLabel)]
                        print("\(output._204)")
                    }
                } catch {
                    print("Cannot Make Prediction")
                }
            } else {
                print("Cannot convert Image to Data")
                return
            }
            
        } catch {
            print("Could get the path to the directory")
        }
    
    }
}
