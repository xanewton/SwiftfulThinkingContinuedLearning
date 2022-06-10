//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-09.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int? // A UserDefaults variable, we use AppStorage because we're in a view
    
    init() {
        count = 0 // set the count back to 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            // Track how many views are initialized
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Scond screen")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("Initialize now!")
        
        // Increase the count variable, we use UserDefaults because we're not in a view
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        
        getData()
    }
    
    deinit {
        print("Deinitialize now!")
        
        // Decrease the count variable, we use UserDefaults because we're not in a view
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        // Case 1: In the foregound thread - Everything is fine the count is always 1
        //data = "new data!!!"
        
        // Case 2: In a background thread - The count increases because of the strong reference
        //DispatchQueue.global().async { // any background task
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 500) { // simulate a long call, 500 seconds
            self.data = "new data!!!"
        }*/
        
        // Case 3: In a background thread - with weak self reference - Problem solved! Now, it's OK if the class deinitializes
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "new data!!!"
        }
    }
    
}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
