//
//  ResetPasswordRequest.swift
//  HealthTracker
//
//  Created by Apple on 25/11/21.
//

import Foundation

struct ResetPasswordRequest : Encodable{
    var phone,password,password_confirmation : String?
}
