//
//  AppointmentDetailController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/08/21.
//

import Foundation
import UIKit


class AppointmentDetailController: InterfaceExtendedController {
    
    var appointment_id : Int?
    var week_id : Int?
    
    var _detailAppointmentInfo : DetailAppointmentInfo?
    
    let TAG = "AppointmentDetailController"
    let tblViewCellId = "cell"
    
    //MARK:-LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariable()
        getAppointmentInfo()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    //MARK:-initialization
    func initializeVariable(){
        rootView.controller = self
        paintInterface()
    }
    
    func paintInterface(){
        paintLogout()
        paintNavigationTitle(text: "Patient Profile")
        paintBackButton()
    }
    
    //MARK:-RootView
    lazy var rootView : AppointmentsDetailRootView = {
        let rootView = AppointmentsDetailRootView()
        return rootView
    }()
    
    init( with info : DetailAppointmentInfo) {
        super.init(nibName: nil, bundle: nil)
        self._detailAppointmentInfo = info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:-GetAppointment Detail info.
    
    func getAppointmentInfo(){
        self.showLoader()
        guard let info = self._detailAppointmentInfo else {
            return
        }
        
        let appointmentRequest = AppointmentRequest(appointment_id: info.apointment_id, week_id: info.week_id)
        
        AppointmentsDetail().getInfo(with: appointmentRequest) { [weak self] info in
            
            guard let self = self else {return}
            Log.echo(key: self.TAG, text: "STOPE LOADER.!!!!!")
            
            self.stopLoader()
            guard let response = info else {
                return
            }
            self.rootView.fillInfo(with: response)
            Log.echo(key: self.TAG, text: "\(String(describing: info))")
        }
    }
}

