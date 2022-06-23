//
//  DownloadingImagesBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-22.
//

import SwiftUI

// Topics covered in this bootcamp:
// - Codable
// - background threads
// - weak self
// - Combine
// - Publishers and Subscribers
// - FileManager
// - NSCache

// URL for API from https://jsonplaceholder.typicode.com/photos
// URL for 1st Image from https://via.placeholder.com/600/92c952
struct DownloadingImagesBootcamp: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    DownloadingImagesRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
