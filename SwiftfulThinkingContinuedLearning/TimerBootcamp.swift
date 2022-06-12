//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-12.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    // viewCurrentTime - Current time
    @State var currentDate: Date = Date()
    var dateFormater: DateFormatter {
        let formater = DateFormatter()
        //formater.dateStyle = .medium
        formater.timeStyle = .medium
        return formater
    }
    
    // viewCountDown
    @State var countDown: Int = 10
    @State var finishText: String? = nil
    
    // viewCountDownToDate
    @State var timeRemainig: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: /*.day*/ .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemainig = "\(hour):\(minute):\(second)"
    }
    
    // viewAnimationCounter
    let timerAnimationCounter = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    
    // viewAnimationTab
    let timerAnimationTab = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    @State var tab: Int = 1
    
    var body: some View {
        //viewCurrentTime
        //viewCountDown
        //viewCountDownToDate
        //viewAnimationCounter
        viewAnimationTab
    }
    
    var viewCurrentTime: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(dateFormater.string(from: currentDate))
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { value in
            currentDate = value
        })
    }
    
    var viewCountDown: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(finishText ?? "\(count)")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
            if countDown <= 1 {
                finishText = "Wow!"
            } else {
                countDown -= 1
            }
        })
    }
    
    var viewCountDownToDate: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(timeRemainig)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer, perform: { _ in
            updateTimeRemaining()
        })
    }
    
    var viewAnimationCounter: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            HStack(spacing: 15) {
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 150)
            .foregroundColor(.white)
        }
        .onReceive(timerAnimationCounter, perform: { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
        })
    }
    
    var viewAnimationTab: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.white, Color.gray]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $tab, content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timerAnimationTab, perform: { _ in
            withAnimation(.default) {
                tab = tab == 5 ? 1 : tab + 1
            }
        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
