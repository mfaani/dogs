//
//  MainView.swift
//  doggs
//
//  Created by mohammad faani on 8/27/25.
//

import SwiftUI

struct MainView: View {
    @State var isLoading = true
    @State var dogs: [Dog] = []
    @State var selectedDog: Dog?
    
    var body: some View {
        
        NavigationSplitView {
            ZStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    List(dogs, selection: $selectedDog) {
                        DogRowView(dog: $0)
                    }
                }
            }
            .onChange(of: selectedDog) { _, newValue in
                print("Selected dog: \(newValue?.id ?? "none")")
            }
            .navigationTitle("Dogs")
            .onAppear(perform: {
                Task {
                    dogs = await DogsRequester().getDogs(limit: 40)
                    isLoading = false
                }
            })
            .padding()
        } detail: {
            selectedDog.map {
                Text($0.id)
            }
        }
    }
}

#Preview {
    MainView()
}
