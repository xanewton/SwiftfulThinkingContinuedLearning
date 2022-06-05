//
//  HashabeBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-05.
//

import SwiftUI

// A hashable is like an unique identifier that doesn't require to store a unique id in the item.
struct MyCustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashabeBootcamp: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "one"),
        MyCustomModel(title: "two"),
        MyCustomModel(title: "three"),
        MyCustomModel(title: "four"),
        MyCustomModel(title: "five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                /*ForEach(data) { item in
                    Text(item.title)
                        .font(.headline)
                }*/
                ForEach(data, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }
            }
        }
    }
}

struct HashabeBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        HashabeBootcamp()
    }
}
