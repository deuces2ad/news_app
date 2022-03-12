//
//  ParentDetailAppointmentController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/09/21.
//

import Foundation
import CoreLocation
import UIKit

class DetailAppointmentController: InterfaceExtendedController {
    
    var appointment_id : Int?
    var week_id : Int?
    
    var _detailAppointmentInfo : DetailAppointmentInfo?
    
    let TAG = "AppointmentDetailController"
    let tblViewCellId = "cell"
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVariable()
        getAppointmentInfo()
        paintNavigationTitle(text: "Appointment Details")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController!.tabBar.isHidden = false
        
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
        paintBackButton()
    }
    
    //MARK: -RootView
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

    //MARK: -GetAppointment Detail info.
    
    func getAppointmentInfo(){
        self.showLoader()
        guard let info = self._detailAppointmentInfo else {
            return
        }

        let appointmentRequest = AppointmentRequest(appointment_id: info.apointment_id)
        self.appointment_id = info.apointment_id
        
        AppointmentsDetail().getInfo(with: appointmentRequest) { [weak self] info in
            
            guard let self = self else {return}
            Log.echo(key: self.TAG, text: "STOP LOADER.!!!!!")
            DispatchQueue.main.async {
                self.stopLoader()
                guard let response = info else {
                    return
                }
                self.rootView.fillInfo(with: response)
                Log.echo(key: self.TAG, text: "\(String(describing: info))")
            }
            
        }
    }
    
    func completeAppointment(){
        let request  = EnrouteStatusRequest(appointment_id: self.appointment_id,status: .completed)
        
        EnrouteStatusService().updateInfo(for: request) { response in
            DispatchQueue.main.async {
                self.stopLoader()
                if response?.success == true{
                    RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: "Are you sure complete this appointment as complete?", successTitle: "Yes", rejectTitle: "", showCancel: true, completion: { success in
                        
                        if success == true{
                            self.navigationController?.popViewController(animated: true)
                        }
                    })
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: response?.message ?? "Error Occured", successTitle: "Ok", rejectTitle: "", showCancel: false, completion: nil)
                }
            }
        }
    }
}
