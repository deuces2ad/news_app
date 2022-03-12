//
//  CurrencyFormatter.swift
//  Rocket_iOS
//
//  Created by Apple on 20/01/22.
//

import Foundation

class CurrencyFormatter: NSObject {
    
   static func convertToIDRFormat(with input: String) ->String{
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.locale = Locale(identifier: "en_id")
       let result = formatter.string(from: Double(input)! as NSNumber)!
       return (result)
   }
}
