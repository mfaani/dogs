//
//  DogRowView.swift
//  doggs
//
//  Created by mohammad faani on 8/30/25.
//

import SwiftUI

/// Note: Can't use `Dog` model directly, because it requires a URL. Or maybe I can? 🤔
struct BreedRowView: View {
    @State var uiimage: UIImage?
    let breed: Breed
    var body: some View {
        HStack {
            if let uiimage {
                Image(uiImage: uiimage)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
            } else {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            Text(breed.name ?? "name")
        }
        .onAppear {
            Task {
                uiimage = await ImageRequester.shared.getImage(URL(string: breed.image.url)!)
            }
        }
    }
}

#Preview {
    BreedRowView(breed: Breed(id: 1, image: Breed.Image(url: "https://i.sstatic.net/E45djvOZ.jpg?s=256", id: "mfaani"), name: "breed2", bredFor: "bfor", breedGroup: "Guard", lifeSpan: "22", temperament: "angry", referenceImageID: "id"))
}

/*
 In List view
 
 for each row, you need an image
  
 DogsRowView(imageRequester + Dog)
 
 DogsRowView(ViewModel)
 ViewModel(ImageRequest + Dog)
 
 */
