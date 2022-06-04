//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-04.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldString: String = ""
    
    var body: some View {
        //scroll1
        scroll2
    }
    
    var scroll1: some View {
        ScrollView {
            ScrollViewReader { proxy in
                Button("Click here to go to #30") {
                    withAnimation(.spring()) { // make it scroll with animation
                        proxy.scrollTo(30, anchor: .center)
                    }
                }
                
                ForEach(0..<50) { index in
                    Text("This is the item # \(index)")
                        .font(.headline)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        .id(index) // We tell the ScrollView where is the item
                }
            }
        }
    }
    
    var scroll2: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldString)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad) // allow only numbers
            
            Button("Scroll now") {
                if let index = Int(textFieldString) {
                    scrollToIndex = index
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is the item # \(index)")
                            .font(.headline)
                            .frame(height: 100)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index) // We tell the ScrollView where is the item
                    }
                    .onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()) { // make it scroll with animation
                            proxy.scrollTo(value, anchor: .top)
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
