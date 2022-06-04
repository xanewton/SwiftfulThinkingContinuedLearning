//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-04.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

/*
Ways to present multiple sheets:
 1 - use a binding (case 3)
 2 - use multiple .sheets (case 4)
 3 - use $item (case 5)
 */

struct MultipleSheetsBootcamp: View {
    
    // variables for case 1
    @State var selectedModelCase1: RandomModel = RandomModel(title: "Starting Title")
    @State var showSheetCase1: Bool = false
    
    // variables for case 2
    @State var selectedModelCase2: RandomModel = RandomModel(title: "Starting Title")
    @State var showSheetCase2: Bool = false
    @State var selectedIndexCase2: Int = 0
    
    // variables for case 3
    @State var selectedModelCase3: RandomModel = RandomModel(title: "Starting Title")
    @State var showSheetCase3: Bool = false
    
    // variables for case 4
    @State var selectedModelCase4: RandomModel = RandomModel(title: "Starting Title")
    @State var showSheetCase4Button1: Bool = false
    @State var showSheetCase4Button2: Bool = false
    
    // variables for case 5
    @State var selectedModelCase5: RandomModel? = nil
    
    var body: some View {
        //multipleSheetsCase1 // Common error
        //multipleSheetsCase2 // Common error
        //multipleSheetsCase3
        //multipleSheetsCase4
        //multipleSheetsCase5
        multipleSheetsExampleCase5
    }
    
    
    // Doesn't work! This approach doesn't work beacuse the content of NextScreen is created after the sheet appears on the screen.
    var multipleSheetsCase1: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModelCase1 = RandomModel(title: "One")
                showSheetCase1.toggle()
            }
            Button("Button 2") {
                selectedModelCase1 = RandomModel(title: "Two")
                showSheetCase1.toggle()
            }
        }
        .sheet(isPresented: $showSheetCase1, content: {
            NextScreen1(selectedModel: selectedModelCase1)
        })
    }
    
    // Doesn't work! This approach doesn't work also beacuse the code inside the content sheet is executed after the sheet is presented to the screen.
    var multipleSheetsCase2: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedIndexCase2 = 1
                //selectedModelCase2 = RandomModel(title: "One")
                showSheetCase2.toggle()
            }
            Button("Button 2") {
                selectedIndexCase2 = 2
                //selectedModelCase2 = RandomModel(title: "Two")
                showSheetCase2.toggle()
            }
        }
        .sheet(isPresented: $showSheetCase2, content: {
            // This function is executed after the sheet is presented to the screen
            if selectedIndexCase2 == 1 {
                NextScreen1(selectedModel: RandomModel(title: "One"))
            } else if selectedIndexCase2 == 2 {
                NextScreen1(selectedModel: RandomModel(title: "Two"))
            } else {
                NextScreen1(selectedModel: RandomModel(title: "Starting Title"))
            }
        })
    }
    
    // Way 1: We make the selectedModel binding. Disadvantage: we need to change the second view.
    var multipleSheetsCase3: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModelCase3 = RandomModel(title: "One")
                showSheetCase3.toggle()
            }
            Button("Button 2") {
                selectedModelCase3 = RandomModel(title: "Two")
                showSheetCase3.toggle()
            }
        }
        .sheet(isPresented: $showSheetCase3, content: {
            NextScreen2(selectedModel: $selectedModelCase3)
        })
    }
    
    // Way 2: We use multiple .sheets. Disadvantege: we repeat code.
    // This works beacuse the views are at the same level. The condition is that you can only have 1 sheet modifier per view hierarchy (the system takes the first parent found).
    var multipleSheetsCase4: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                showSheetCase4Button1.toggle()
            }
            .sheet(isPresented: $showSheetCase4Button1, content: {
                NextScreen1(selectedModel: RandomModel(title: "One"))
            })
            
            Button("Button 2") {
                showSheetCase4Button2.toggle()
            }
            .sheet(isPresented: $showSheetCase4Button2, content: {
                NextScreen1(selectedModel: RandomModel(title: "Two"))
            })
        }
    }
    
    // Way3: use $item
    var multipleSheetsCase5: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModelCase5 = RandomModel(title: "One")
            }
            Button("Button 2") {
                selectedModelCase5 = RandomModel(title: "Two")
            }
        }
        .sheet(item: $selectedModelCase5, content: { model in
            NextScreen1(selectedModel: model)
        })
    }
    
    var multipleSheetsExampleCase5: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModelCase5 = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModelCase5, content: { model in
                NextScreen1(selectedModel: model)
            })
        }
    }
}

struct NextScreen1: View {
    
    @State var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct NextScreen2: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}


struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
