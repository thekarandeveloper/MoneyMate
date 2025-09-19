//
//  NotificationManager.swift
//  MoneyMate
//
//  Created by Karan Kumar on 19/09/25.
//


import Foundation
import UserNotifications
import FirebaseMessaging
import UIKit

final class NotificationManager: NSObject, ObservableObject {
    static let shared = NotificationManager()
    
    private override init() {}
    
    // MARK: - Request Permission
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    print("✅ Notifications permission granted")
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    print("❌ Notifications permission denied")
                }
            }
        }
    }
    
    // MARK: - Local Notification
    func scheduleLocalNotification(title: String, body: String, inSeconds: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Local notification error: \(error.localizedDescription)")
            } else {
                print("📩 Local notification scheduled in \(inSeconds) seconds")
            }
        }
    }
    
    // MARK: - Remote Notification Setup
    func configureRemoteNotifications() {
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    // Show banner while app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    // Handle taps on notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("📲 User tapped notification: \(response.notification.request.identifier)")
        completionHandler()
    }
}

// MARK: - MessagingDelegate (Firebase)
extension NotificationManager: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("📲 Firebase FCM Token: \(fcmToken ?? "")")
        // TODO: Send this token to your backend if needed
    }
}
