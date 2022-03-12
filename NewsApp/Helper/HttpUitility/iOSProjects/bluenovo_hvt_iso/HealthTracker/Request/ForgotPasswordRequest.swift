//
//  ForgotPasswordRequest.swift
//  HealthTracker
//
//  Created by Apple on 24/11/21.
//

import Foundation

struct ForgotPasswordRequest : Encodable {
    var phone : String?
    var token : String?
}

