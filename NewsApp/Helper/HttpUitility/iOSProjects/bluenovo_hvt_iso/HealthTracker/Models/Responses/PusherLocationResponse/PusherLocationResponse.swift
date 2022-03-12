//
//  PusherLocationResponse.swift
//  HealthTracker
//
//  Created by Grazitti on 24/09/21.
//

import Foundation

struct PusherLocationResponse: Decodable {
    var location: LocationInfo?
    var appointmentID: String?
    var userID: Int?

    enum CodingKeys: String, CodingKey {
        case location
        case appointmentID = "appointment_id"
        case userID = "user_id"
    }
}

// MARK: - Location
struct LocationInfo: Decodable {
    var lat, lng: String?
}
