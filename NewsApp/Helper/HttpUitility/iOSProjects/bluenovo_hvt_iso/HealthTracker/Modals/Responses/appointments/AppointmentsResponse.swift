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
    var allAppointments, todaysAppointments: [AppointmentInfo]?
}

// MARK: - Appointment
struct AppointmentInfo: Decodable {
    var appointmentID: Int?
    var visitType, appointmentDate, notes: String?
    var weekID: Int?

    enum CodingKeys: String, CodingKey {
        case appointmentID = "appointment_id"
        case visitType = "visit_type"
        case appointmentDate = "appointment_date"
        case notes
        case weekID = "week_id"
    }
}
