//
//  AppointmentsCellDelegate.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/08/21.
//

import Foundation


protocol AppointmentsCellDelegate : AnyObject {
    func didTapOnCell(with appointmentInfo: DetailAppointmentInfo)
}
