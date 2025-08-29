//
//  ContentView.swift
//  doggs
//
//  Created by mohammad faani on 8/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            SwiftUI.Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear(perform: {
            Task {
                let dogs = await Requester().getDogs()
            }
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
