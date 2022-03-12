//
//  Log.swift
//  GGStaff
//
//  Created by Abhishek Dhiman on 13/12/21.
//  Copyright © 2021 Abhishek Dhiman. All rights reserved.
//


import Foundation

@objc class Log : NSObject{
    
    @objc static func echo(key : String = "", text : Any? = ""){
        
        if(!DevFlag.debug){
            return
        }
        
        if(key != DevFlag.key && !DevFlag.showAll){
            return
        }
        
        guard let textEx = text
            else{
                print("\(key) -> nil")
                return
        }
        
        print("\(key) -> \(textEx)")
        
//        print("\(String(describing: DateParser.dateToStringInServerFormat(Date()))) \(key) -> \(textEx)")
    }
}
