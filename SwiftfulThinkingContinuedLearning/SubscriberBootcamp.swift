//
//  SubscriberBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-13.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {

    // The publisher can be any variable type
    @Published var count: Int = 0
    //var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>() // if we have multiple publishers
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func setUpTimer() {
        //timer = Timer
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect() // start the timer
            .sink(receiveValue: { [weak self] _ in // subscribe
                guard let self = self else { return } // check null
                self.count += 1
                
                // cancel at some condion
                /* if self.count >= 10 {
                    //self.timer?.cancel()
                    for item in self.cancellables {
                        item.cancel()
                    }
                } */
            })
            .store(in: &cancellables)
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // wait 0.5 seconds before running the functions (until the user finished typing).
            .map { (text) -> Bool in // check the text every time it changes, we convert to a boolean
                if text.count > 3 {
                    return true
                }
                return false
            }
            //.assign(to: \.textIsValid, on: self) // there is no way to do self weak
            .sink(receiveValue: { [weak self] (isValid) in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count) // e combine with another publisher
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            //Text("Text is valid: \(vm.textIsValid.description)")
            
            // Every time someone types something the textFieldText var will be updated. This will be a publisher.
            TextField("Type something here...", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .font(.headline)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0.0 :
                                vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                    }
                    .font(.title)
                    .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(22)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
