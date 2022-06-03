//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-03.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        //gesture1
        gesture2
    }
    
    var gesture1: some View {
        Text(isComplete ? "COMPLETED" : "NOT COMPLETED")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? Color.green : Color.gray)
            .cornerRadius(10)
            /*.onTapGesture {
                isComplete.toggle()
            }*/
            .onLongPressGesture {
                isComplete.toggle()
            }
            /*.onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50) {
                isComplete.toggle()
            }*/
    }
    
    var gesture2: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the minimum duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }

                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
