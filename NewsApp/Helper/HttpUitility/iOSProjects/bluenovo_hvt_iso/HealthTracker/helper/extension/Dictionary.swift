//
//  Dictionary.swift
//  Health Tracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//

import Foundation

public extension Dictionary {
    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
    /// values of the keys that are already set
    ///
    /// :param dictionaries A comma seperated list of dictionaries
    mutating func merge<K, V>(_ dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
    
    func JSONDescription()->String{
        
        let dict = self
        
        guard let JSONData: Data = try? JSONSerialization.data(withJSONObject: dict, options: [])
            else{
                return ""
        }
        
        let str = String(data:JSONData , encoding: String.Encoding.utf8) ?? ""
        
        return str
        
    }
}
