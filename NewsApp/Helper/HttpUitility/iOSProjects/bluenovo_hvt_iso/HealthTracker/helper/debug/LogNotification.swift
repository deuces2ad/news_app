
//
//  LogNotification.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import UserNotifications

class LogNotification{
    
    init(){
        
    }
    
    private func initialization(){
        
    }
    
    func notify(text : String){
        return;
        if(!DevFlag.debug){
            return
        }
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {[weak self] (settings) in
            if settings.authorizationStatus != .authorized {
                return
            }
            self?.displayLocalNotification(text: text)
        }
        
    }
    
    private func displayLocalNotification(text : String){
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Development"
        content.body = text
        content.sound = UNNotificationSound.default
        
        // Swift
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
                                                        repeats: false)
        
        // Swift
        let identifier = "notification"
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if error != nil {
            }
        })
    }
    
}
