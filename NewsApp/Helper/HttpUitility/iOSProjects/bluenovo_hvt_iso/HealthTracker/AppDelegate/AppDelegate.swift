//
//  AppDelegate.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import UIKit
import GoogleMaps
import Firebase
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window:UIWindow?
    var isRootInitialize:Bool = false
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppOrientation.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)

        GMSServices.provideAPIKey(AppConnectionConfig.GoogleMapKey)
        initialization()
        FirebaseApp.configure()
        UserSocket.sharedInstance?.connectToPusher()

        return true
    }
    
    func initialization(){
        registerForPushNotifications()
        _ = NavigationBarCustomizer()
        
        

        RootControllerManager().setRoot { [weak self] in
            guard let self = self else {return}
            self.isRootInitialize = true
//            self.setupBadgeValue()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        Log.echo(key: "abhishekD", text: "ApplicationDidBecomeActive is calling")

        if self.isRootInitialize{
            
        }

        
    }
    
    func registerForPushNotifications() {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                print("Permission granted: \(granted)")
                // 1. Check if permission granted
                guard granted else { return }
                // 2. Attempt registration for remote notifications on the main thread
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            // 1. Convert device token to string
            let tokenParts = deviceToken.map { data -> String in
                return String(format: "%02.2hhx", data)
            }
            let token = tokenParts.joined()
            // 2. Print device token to use for PNs payloads
            print("Device Token: \(token)")
            UserDefaults.standard.setValue(token, forKey: "device_token")
        }

        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            // 1. Print out error if PNs registration not successful
            print("Failed to register for remote notifications with error: \(error)")
        }
    
   

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
}

