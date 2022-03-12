//
//  EmailLoginRequest.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation

struct EmailLoginRequest : Encodable {
    let email , password , device_token, device_type : String
}
