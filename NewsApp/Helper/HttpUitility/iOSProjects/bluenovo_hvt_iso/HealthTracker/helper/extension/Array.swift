//
//  Array.swift
///  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation


public extension Array{
    
    func JSONDescription()->String{
        let array = self
        guard let JSONData: Data = try? JSONSerialization.data(withJSONObject: array, options: [])
            else{
                return ""
        }
        
        let str = String(data:JSONData , encoding: String.Encoding.utf8) ?? ""
        return str
    }
    
}
