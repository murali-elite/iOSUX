//
//  ContentView.swift
//  iOSUXSample
//
//  Created by Murali moorthy on 7/29/24.
//

import SwiftUI
import iOSUXPackage

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        Sample()
        
    }
}

#Preview {
    ContentView()
}