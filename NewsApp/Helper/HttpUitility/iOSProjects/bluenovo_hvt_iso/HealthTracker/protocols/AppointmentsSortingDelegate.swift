//
//  AppointmentsSortingDelegate.swift
//  HealthTracker
//
//  Created by Apple on 01/10/21.
//

import Foundation

protocol AppointmentsSortingDelegate :AnyObject{
    func didEndSorting(info : [Appointmensts])
}
