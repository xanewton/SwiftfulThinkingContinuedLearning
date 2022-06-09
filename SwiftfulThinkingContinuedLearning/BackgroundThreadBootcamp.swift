//
//  BackgroundThreadBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-09.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        /*
         We use a background thread.
         Other background threads:
          - utility, <- Things that the user don't know we're doing
          - background, <- Normally to do procesing
          - default,
          - unspecified, <- It doesn't matter
          - userInitiated, <- It prevents the app from being usable
          - userInteractive <- Animations, event handling or updating the user interface.
         //DispatchQueue.global(qos: .utility)
         */
        //DispatchQueue.global().async {
        DispatchQueue.global(qos: .background).async {
            // We use self, because the background thread needs a way to pass data to the class.
            let newData = self.downloadData()
            self.printThreadInformation(text: "Check 1. While downloading data!")
            
            // Since publishing changes to the main tread from a background thread is not allowed.
            // The #1 rule: you can do things in the background, but if you're going to affect the UI, you need to do that in the main thread.
            DispatchQueue.main.async {
                self.dataArray = newData
                self.printThreadInformation(text: "Check 2. While publishing data!")
            }
        }
    }
    
    private func printThreadInformation(text: String) {
        print("\(text): Is main thread? \(Thread.isMainThread)")
        print("\(text): Thread info: \(Thread.current)")
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("Load data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
