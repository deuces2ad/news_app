//
//  AppointmentDetailResponse.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/08/21.
//



import Foundation

// MARK: - Welcome
struct AppointmentDetailResponse: Decodable {
    var success: Bool?
    var data: Details?
    var message: String?
}

// MARK: - DataClass
struct Details: Decodable {
    var appointmentID: Int?
    var visitType: String?
    var appointmentDate: Int?
    var notes, appointmentStatus, staffName, staffEmail: String?
    var staffAddress: String?
    var staffLatitude, staffLongitude: Double?
    var staffImage: String?
    var staffPhone, staffLicenseNumber, patientName, patientEmail: String?
    var patientAddress: String?
    var patientLatitude, patientLongitude: Double?
    var patientGender: String?
    var patientDob: Int?
    var patientPreferredLanguage: String?
    var patientImage: String?
    var patientPhone: String?
    var staffType: String?

    enum CodingKeys: String, CodingKey {
        case appointmentID = "appointment_id"
        case visitType = "visit_type"
        case appointmentDate = "appointment_date"
        case notes
        case appointmentStatus = "appointment_status"
        case staffName = "staff_name"
        case staffEmail = "staff_email"
        case staffAddress = "staff_address"
        case staffLatitude = "staff_latitude"
        case staffLongitude = "staff_longitude"
        case staffImage = "staff_image"
        case staffPhone = "staff_phone"
        case staffLicenseNumber = "staff_licenseNumber"
        case patientName = "patient_name"
        case patientEmail = "patient_email"
        case patientAddress = "patient_address"
        case patientLatitude = "patient_latitude"
        case patientLongitude = "patient_longitude"
        case patientGender = "patient_gender"
        case patientDob = "patient_dob"
        case patientPreferredLanguage = "patient_preferredLanguage"
        case patientImage = "patient_image"
        case patientPhone = "patient_phone"
        case staffType = "staff_type"
    }
}


