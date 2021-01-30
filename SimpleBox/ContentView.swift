//
//  ContentView.swift
//  SimpleBox
//
//  Created by Bratislav Ljubisic on 30.01.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @State private var fileContent = ""
  @State private var showDocumentPicker = false
  
  var body: some View {
    VStack {
      Text(fileContent).padding()
      
      Button("Select File") {
        showDocumentPicker = true
      }
    }
    .sheet(isPresented: self.$showDocumentPicker) {
      DocumentPicker(fileContent: $fileContent)
    }
  }
}

struct DocumentPicker: UIViewControllerRepresentable {
  @Binding var fileContent: String
  
  func makeCoordinator() -> DocumentPickerCoordinator {
    return  DocumentPickerCoordinator(fileContent: $fileContent)
  }
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
    let controller: UIDocumentPickerViewController
    
    controller = UIDocumentPickerViewController(forOpeningContentTypes: [.text], asCopy: true)
    controller.delegate = context.coordinator
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {}
}

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
  
  @Binding var fileContent: String
  
  init(fileContent: Binding<String>) {
    _fileContent = fileContent
  }
  
  func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    let fileURL = urls[0]
    
    do {
      fileContent = try String(contentsOf: fileURL, encoding: .utf8)
    } catch let error {
      print(error.localizedDescription)
    }
  }
}


