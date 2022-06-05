//
//  LocalNotificationsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by newtan on 2022-06-05.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (sucess, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success!")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notification title"
        content.subtitle = "Notification subtitle"
        content.sound = .default
        content.badge = 1
        
        // There are 3 types of Notification triger
        // time - Example: Every 5 seconds
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // calendar - Example: Every day at 10:52 am
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 52
        //dateComponents.weekday = 2 // asign a weekday to repeat. Ex. every Monday
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // location - Example: Every entre and leave a certain location
        /*let coordinates = CLLocationCoordinate2D(
            latitude: 40.0,
            longitude: 50.0)
        let region = CLCircularRegion(
            center: coordinates,
            radius: 100,
            identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true */
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

// Schedule Local Notifications
struct LocalNotificationsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0 // remove badge
        }
    }
}

struct LocalNotificationsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotificationsBootcamp()
    }
}
