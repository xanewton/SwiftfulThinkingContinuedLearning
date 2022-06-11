//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-10.
//

import SwiftUI

class EscapingViewModel: ObservableObject {
    
    @Published var text: String = "Hello"
    
    func getData() {
        // Way 1: Fake it!
        //text = downloadData1()
        
        // Way 2: Using a completion Handler
        /*downloadData2 { data in
            text = data
        }*/
        
        // Way 3: Using a completion Handler + asyncronous + weak self
        /*downloadData3 { [weak self] data in
            self?.text = data
        }*/
        
        // Way 4: Same as 3 + return model
        /*downloadData4 { [weak self] result in
            self?.text = result.data
        }*/
        
        // Way 4: Same as 4 + typealias
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    func downloadData1() -> String {
        // Asyncronous code
        return "New data!"
    }
    
    /*
     We cannot return a value using a normal return with a delay.
     func downloadData2() -> String {
         // We must return a value inmediately
         DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
             return "New data!"
         }
     }
     */
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        // (_ data: String) -> Void   is the equivalent to a function:
        // func someFunction(_ data: String) -> Void
        // func someFunction(_ data: String) -> ()
        // where Void = ()
        completionHandler("New data!")
    }
    
    // @escaping makes the completionHandler function asynchronous
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New data!")
        }
    }
    
    // Same as 3, but we return a model because we may have a bunch of values to return
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
