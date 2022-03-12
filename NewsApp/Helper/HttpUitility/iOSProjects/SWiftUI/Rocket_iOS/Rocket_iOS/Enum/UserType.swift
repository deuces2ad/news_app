//
//  UserType.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import Foundation


enum UserType : Int {
    
    case NotRegisteredUser = 0
    case RegisteredNoKYC = 1
    case KYCOnProgress  = 2
    case KYCApproved  = 3
}
