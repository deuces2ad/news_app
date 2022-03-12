//
//  LocationEmiterResponse.swift
//  HealthTracker
//
//  Created by Grazitti on 22/09/21.
//

import Foundation

// MARK: - Welcome
struct Welcome: Decodable {
    let success: Bool
    let data: LocationData
    let message: String
}

// MARK: - DataClass
struct LocationData: Decodable {
    let lat, lng: String
}

