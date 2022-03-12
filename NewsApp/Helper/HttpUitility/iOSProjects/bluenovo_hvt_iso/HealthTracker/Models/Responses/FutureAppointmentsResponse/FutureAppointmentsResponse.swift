//
//  FutureAppointmentsResponse.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/11/21.
//


import Foundation

// MARK: - Welcome
struct FutureAppointmentsResponse: Decodable {
    var success: Bool?
    var data: AppointmentData?
    var message: String?
}

// MARK: - DataClass
struct AppointmentData: Decodable {
    var allAppointments: [AllAppointment]?
}

// MARK: - AllAppointment
struct AllAppointment: Decodable {
    var date: Int?
    var appointments: [Appointment]?
}

// MARK: - Appointment
struct Appointment: Decodable {
    var appointmentID: Int?
    var visitType: String?
    var appointmentDate: Int?
    var notes: String?
    var appointmentStatus: String?
    var patientName: String?
    var patientEmail: String?
    var patientAddress: String?
    var patientLatitude, patientLongitude: Double?
    var patientPhone: String?
    var patientImage: String?
    var patientGender: String?
    var patientDob: Int?
    var patientPreferredLanguage: String?
    var date: String?

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
        case date
    }
}

enum AppointmentStatus: String, Decodable {
    case pending = "PENDING"
}

enum PatientEmail: String, Codable {
    case eddiYopmailCOM = "eddi@yopmail.com"
    case gregYopmailCOM = "greg@yopmail.com"
    case johnYopmailCOM = "john@yopmail.com"
    case silivaYopmailCOM = "siliva@yopmail.com"
}


enum PatientName: String, Decodable {
    case eddiGorwan = "Eddi Gorwan"
    case gregDevin = "Greg Devin"
    case johnWhey = "John Whey"
    case silivaMcGrey = "Siliva McGrey"
}

enum PatientPreferredLanguage: String, Decodable {
    case english = "English"
    case hindi = "Hindi"
    case punjabi = "Punjabi"
    case spanish = "Spanish"
}

enum VisitType: String, Decodable {
    case hmvisPrim = "HMVIS Prim"
    case testVisitType = "Test Visit Type"
}

