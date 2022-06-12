//
//  DownloadWithCombine.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-12.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    // You could check in https://app.quicktype.io/ to get an example of how to make a struct for a JSON object.
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // Example requests from https://jsonplaceholder.typicode.com/
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine discussion https://developer.apple.com/documentation/combine
        /*
        // 1. Sign up for monthly subscription for package to be delivered
        // 2. The company would make the package behind the scenes
        // 3. Receive the package at your front door
        // 4. Make sure the box isn't damaged
        // 5. Open and make sure the item is correct
        // 6. Use the item!
        // 7. Cancellable at any time!
        
        // 1. Create the publisher
        // 2. Subscribe publisher on background thread
        // 3. Receive on the main thread
        // 4. tryMap (check that the data is good)
        // 5. Decode (decode data into PostModels)
        // 6. Sink (put the item into the app)
        // 7. Store (cancel subscription if needed)
         */
        URLSession.shared.dataTaskPublisher(for: url)
            //.subscribe(on: DispatchQueue.global(qos: .background)) //not needed, by default is a background thread
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            /* .replaceError(with: []) // to not care about the error, then you don't need to handle errors in .sink
            .sink(receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }) */
            .sink { (completion) in
                //print("Completion: \(completion)")
                switch completion {
                case .finished:
                    print("Finished!")
                case .failure(let error):
                    // Handle the errors thrown by handleOutput
                    print("There was an error: \(error)")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
