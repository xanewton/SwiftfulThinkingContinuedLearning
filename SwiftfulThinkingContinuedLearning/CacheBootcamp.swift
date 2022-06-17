//
//  CacheBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-16.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager() // Singleton
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        // The cache will only add items up to the set limits, if another one comes, it will empty the cache for that new one.
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // number of objects
        cache.totalCostLimit = 1024 * 1024 * 100 // 100Mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String {
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to Cache!"
    }
    
    func remove(name: String) -> String {
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from Cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CacheViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "einstein"
    let manager = CacheManager.instance
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from the Cache!"
        } else {
            infoMessage = "Image not found on the Cache!"
        }
    }
}

struct CacheBootcamp: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 160)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                HStack{
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from Cache")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 160)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Bootcamp")
        }
    }
}

struct CacheBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CacheBootcamp()
    }
}
