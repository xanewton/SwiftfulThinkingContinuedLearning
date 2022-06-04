//
//  GeometryReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-04.
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        //splitScreen1
        //splitScreen2
        scrollScreen
    }
    
    var splitScreen1: some View {
        // We want a screen with 2/3 for the fist color.
        // Problem: UIScreen uses the width of the iPhone, not the current screen rotated.
        HStack(spacing: 0) {
            Rectangle()
                .fill(Color.blue)
                .frame(width: UIScreen.main.bounds.width * 0.6666)
            
            Rectangle()
                .fill(Color.red)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var splitScreen2: some View {
        // We want a screen with 2/3 for the fist color.
        // The GeometryReader uses the current size of the current screen when the device changes. It's useful when the device rotates orientation. However, it's expensive. If you put too many GeometryReaders it will slow down the app slowly.
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle()
                    .fill(Color.red)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    var scrollScreen: some View {
        // Other use of the GeometryReader is to get the exact location of an object.
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                // We use the geometry to change the angle as the rectangle moves across the screen.
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 250, height: 200)
                    .padding()
                }
            }
        })
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2 // The starting point
        let currentX = geo.frame(in: .global).midX // Calculate the center of the rectangle
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
