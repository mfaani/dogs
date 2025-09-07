//
//  DogRowView.swift
//  doggs
//
//  Created by mohammad faani on 8/30/25.
//

import SwiftUI

var dogNames = ["Hunter", "Dexter", "Bugzy", "Hippo", "Al", "Rex", "Deep", "Happy", "Thump"]

struct DogViewModel {
    let dog: Dog
    
    var name: String {
        dogNames.randomElement() ?? "Hunter"
    }
}

/// Note: Can't use `Dog` model directly, because it requires a URL. Or maybe I can? 🤔
struct DogRowView: View {
    @State var uiimage: UIImage?
    let dog: Dog
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
            
            Text(dog.breeds.first?.breedGroup ?? "BGroup")
        }
        .onAppear {
            Task {
                uiimage = await ImageRequester.shared.getImage(URL(string: dog.url)!)
            }
        }
    }
}

#Preview {
    DogRowView(dog: Dog(breeds: [Breed(id: 1, name: "breed2", bredFor: "bfor", breedGroup: "Guard", lifeSpan: "22", temperament: "angry", referenceImageID: "id")], id: "aaa", url: "aabc", width: 400, height: 600))
}

/*
 In List view
 
 for each row, you need an image
  
 DogsRowView(imageRequester + Dog)
 
 DogsRowView(ViewModel)
 ViewModel(ImageRequest + Dog)
 
 */
