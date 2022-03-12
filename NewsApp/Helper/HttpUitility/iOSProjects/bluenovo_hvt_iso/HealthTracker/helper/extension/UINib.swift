//
//  UINib.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation
import UIKit


public extension UINib {
   
     public static func universalNib(nibName : String, bundle : Bundle? = nil)->UINib{
        let name = nibName + (UIDevice.current.userInterfaceIdiom == .pad ? "_iPad" : "_iPhone")
        return UINib(nibName : name, bundle : nil)
    }
}
