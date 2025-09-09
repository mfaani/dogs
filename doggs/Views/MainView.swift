//
//  MainView.swift
//  doggs
//
//  Created by mohammad faani on 8/27/25.
//

import SwiftUI

struct MainView: View {
    @State private var searchText = ""
    @State private var isLoading = true
    @State private var breeds: [Breed] = []
    @State private var selectedBreed: Breed?
    
    var body: some View {
        
        NavigationSplitView {
            ZStack {
                if isLoading {
                    ProgressView("Loading...")
                } else {
                    List(breeds, id: \.self, selection: $selectedBreed) {
                        BreedRowView(breed: $0)
                    }
                }
            }
            .onChange(of: selectedBreed) { _, newValue in
                print("Selected dog: \(newValue?.id ?? 10)")
            }
            .navigationTitle("Breeds")
            .onAppear(perform: {
                Task {
                    breeds = await BreedsRequester().getBreeds(limit: 40)
                    isLoading = false
                }
            })
            .padding()
        } detail: {
            if let selectedBreed {
                Text(selectedBreed.name ?? "no name")
                Text(selectedBreed.temperament ?? "normie")
            }
        }
        .searchable(text: $searchText, prompt: "Search for a resort")

    }
}

#Preview {
    MainView()
}
