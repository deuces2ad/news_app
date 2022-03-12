//
//  GeoCodeInfo.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 05/08/21.
//

import Foundation

import Foundation

// MARK: - Welcome
struct GeoCodeInfo: Decodable {
    let plusCode: PlusCode
    let results: [LocationResult]
    let status: String

    enum CodingKeys: String, CodingKey {
        case plusCode = "plus_code"
        case results, status
    }
}

// MARK: - PlusCode
struct PlusCode: Decodable {
    let compoundCode, globalCode: String

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

// MARK: - Result
struct LocationResult: Decodable {
    let addressComponents: [AddressComponent]
    let formattedAddress: String
    let geometry: Geometry
    let placeID: String
    let plusCode: PlusCode?
    let types: [String]

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case formattedAddress = "formatted_address"
        case geometry
        case placeID = "place_id"
        case plusCode = "plus_code"
        case types
    }
}

// MARK: - AddressComponent
struct AddressComponent: Decodable {
    let longName, shortName: String
    let types: [String]

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - Geometry
struct Geometry: Decodable {
    let location: Location
    let locationType: String
    let viewport: Bounds
    let bounds: Bounds?

    enum CodingKeys: String, CodingKey {
        case location
        case locationType = "location_type"
        case viewport, bounds
    }
}

// MARK: - Bounds
struct Bounds: Decodable {
    let northeast, southwest: Location
}

// MARK: - Location
struct Location: Decodable {
    let lat, lng: Double
}


