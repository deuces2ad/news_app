//
//  ForgotPasswordResponse.swift
//  HealthTracker
//
//  Created by Apple on 24/11/21.
//


import Foundation

// MARK: - Welcome
struct ForgotPasswordResponse: Decodable {
    var success: Bool?
    var message: String?
    var data: [String]?
}
