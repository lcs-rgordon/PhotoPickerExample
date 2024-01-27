//
//  ContentView.swift
//  PhotoPickerExample
//
//  Created by Russell Gordon on 2024-01-27.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    @State private var landmarkItem: PhotosPickerItem?
    @State private var landmarkImage: Image?
    @State private var result: String = ""
    
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            // SEE: https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-pictures-using-photospicker
            PhotosPicker(
                "Select landmark",
                selection: $landmarkItem,
                matching: .images
            )
            .onChange(of: landmarkItem) {
                Task {
                    if let loaded = try? await landmarkItem?.loadTransferable(type: Image.self) {
                        landmarkImage = loaded
                        result = "Success"
                    } else {
                        result = "Failed"
                    }
                }
            }
            
            landmarkImage?
                .resizable()
                .scaledToFit()
            
            Text("**Result:** \(result)")
        }
    }
}

#Preview {
    ContentView()
}
