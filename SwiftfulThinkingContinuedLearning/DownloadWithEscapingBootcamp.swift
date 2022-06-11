//
//  DownloadWithEscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-11.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    // You could check in https://app.quicktype.io/ to get an example of how to make a struct for a JSON object.
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // Example requests from https://jsonplaceholder.typicode.com/
        // 1 post - https://jsonplaceholder.typicode.com/posts/1
        // many posts - https://jsonplaceholder.typicode.com/posts
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromUrl: url) { returnedData in
            if let data = returnedData {
                // Read the post
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                // Update in UI Thread
                DispatchQueue.main.sync { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned!")
            }
        }
    }
    
    func downloadData(fromUrl url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        // We use an @escaping function, because the function is executing in the background after some time (asyncronous), not inmediately.
        // URLSession.shared.dataTask is by default in a background thread
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            /*
            guard let data = data else {
                print("No data")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            // https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code shoild be 2xx, but is \(response.statusCode)")
                return
            } */
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error dowloading data!")
                completionHandler(nil) // We want to return nil if there is an error
                return
            }

            // Print the data
            /* print("Sucess downloading data!")
            print(data)
            let jsonData = String(data: data, encoding: .utf8)
            print(jsonData) */
            
            completionHandler(data)
        }.resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
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

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
