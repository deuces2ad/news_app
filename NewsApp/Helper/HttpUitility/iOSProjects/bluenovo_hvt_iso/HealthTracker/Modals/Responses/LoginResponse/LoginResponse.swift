//
//  LoginResponse.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation

struct LoginResponse: Decodable {
    var success: Bool?
    var data: DataClass?
    var message: String?
}

// MARK: - DataClass
struct DataClass: Decodable {
    var token, email, name, role: String?
    var phone: Int?
    var address, state, city, zipcode: String?
    var dob,gender,image,licenseNumber,preferredLanguage,notes: String?

    enum CodingKeys: String, CodingKey {
        case token, email, name, role, phone, address, state, city, zipcode, image,dob
        case licenseNumber = "license_number"
        case preferredLanguage = "preferred_language"
    }
}
