//
//  Rocket_iOSApp.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 14/12/21.
//

import SwiftUI

// Entry point for below iOS 14

@main
struct Rocket_iOSAppWrapper {
    
    static func main(){
        
        if #available(iOS 14.0, *) {
            Rocket_iOSApp.main()
        }
        else {
            UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(AppDelegate.self))
        }
    }
}

 // Entry point for above iOS 14

@available(iOS 14.0, *)
struct Rocket_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {

        WindowGroup {
            SplashView()
                .navigationBarItems(trailing: EmptyView())
        }
    }
}
