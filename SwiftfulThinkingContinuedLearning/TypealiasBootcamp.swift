//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-09.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

/*struct TVModel {
    let title: String
    let director: String
    let count: Int
}*/

// We use a typealias to create a new type equal to an existing type
typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    //@State var item: MovieModel = MovieModel(title: "Terminator", director: "Joe", count: 5)
    @State var item: TVModel = TVModel(title: "Titanic", director: "Emily", count: 20)
    
    var body: some View {
        VStack {
            Text("Title: \(item.title)")
            Text("Director: \(item.director)")
            Text("Count: \(item.count)")
        }
    }
}

struct TypealiasBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBootcamp()
    }
}
