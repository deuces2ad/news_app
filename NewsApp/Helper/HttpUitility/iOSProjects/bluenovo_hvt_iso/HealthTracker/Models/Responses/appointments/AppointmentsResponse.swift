//
//  AppointmentsResponse.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 12/08/21.
//

import Foundation


// MARK: - Welcome
struct AppointmentsResponse: Decodable {
    var success: Bool?
    var data: AppointmentsData?
    var message: String?
}

// MARK: - DataClass
struct AppointmentsData: Decodable {
    var allAppointments, pendingAppointments: [AppointmentInfo]?
}

// MARK: - Appointment
struct AppointmentInfo: Decodable {
    var appointmentID: Int?
    var visitType: String?
    var appointmentDate: Int?
    var notes: String?
    var appointmentStatus: String?
    var patientName, patientEmail, patientAddress: String?
    var patientLatitude, patientLongitude: Double?
    var patientPhone: String?
    var patientImage: String?
    var patientGender: PatientGender?
    var patientDob: Int?
    var patientPreferredLanguage: String?
    var staffName : String?

    enum CodingKeys: String, CodingKey {
        case appointmentID = "appointment_id"
        case visitType = "visit_type"
        case appointmentDate = "appointment_date"
        case notes
        case appointmentStatus = "appointment_status"
        case patientName = "patient_name"
        case patientEmail = "patient_email"
        case patientAddress = "patient_address"
        case patientLatitude = "patient_latitude"
        case patientLongitude = "patient_longitude"
        case patientPhone = "patient_phone"
        case patientImage = "patient_image"
        case patientGender = "patient_gender"
        case patientDob = "patient_dob"
        case patientPreferredLanguage = "patient_preferredLanguage"
        case staffName = "staff_name"
    }
}

enum PatientGender: String, Decodable {
    case female = "Female"
    case male = "Male"
}
