//
//  AppOrientation.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 27/12/21.
//

import Foundation
import UIKit

struct AppOrientation {
    
    static var allowRotate : Bool = false

   static func changeOrientationToPortrait(){
        
        if let _ = UIApplication.shared.delegate as? AppDelegate{
            
            AppOrientation.allowRotate = false
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }
}
