//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-04.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        //ratingWithCount
        ratingWithMask
    }
    
    var ratingWithCount: some View {
        ZStack {
            HStack {
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
    }
    
    var ratingWithMask: some View {
        starsView
            .overlay(
                overlayView
                    .mask(starsView)
            )
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Since we are using a rectangle, we can customize it
                Rectangle()
                    //.foregroundColor(Color.yellow)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false) // don't allow clicks
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
