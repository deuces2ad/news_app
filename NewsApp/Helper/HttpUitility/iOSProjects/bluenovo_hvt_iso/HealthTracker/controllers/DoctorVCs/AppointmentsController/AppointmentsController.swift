//
//  EventController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/07/21.
//

import Foundation
import UIKit
import CoreLocation

class AppointmentsController: InterfaceExtendedController {
    
    let TAG = "AppointmentsController"
    let tblViewCellId = "cell"
    
    var allAppointmentsInfo = [Appointmensts]()
    var todayAppointmentsInfo = [Appointmensts]()
    var appoitmentsLocations = [CLLocationCoordinate2D]()
    var delegate : DeatailedTrackInfoDelegate?
    
    
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
        getAppointmentsInfo()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
        rootView.controller = self
       
    }
    
    //MARK:- Intialization
    fileprivate func intializeVariable(){
        rootView.detailedTrackInfo.delagate = self
        paintInterface()
        
    }
    
    fileprivate func paintInterface(){
        view.backgroundColor = .white
        paintNavigationTitle(text: "Appointments")
        paintLogout()
        paintHideBackButton()
        
    }
    
    fileprivate func setupTblView(){
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(AppointmentsCell.self, forCellReuseIdentifier: tblViewCellId)
        rootView.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func handleSeletionOfTabs(){
        Log.echo(key: "aa", text: "Tapped!!")
        let selectedIndex = rootView.menuBar.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            rowsTodisplay = todayAppointmentsInfo
            rootView.detailedTrackBottomAnchor?.constant = -30
        case 1:
            rowsTodisplay = allAppointmentsInfo
            rootView.detailedTrackBottomAnchor?.constant = 60
        default: break
            
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        rootView.menuBar.changeUnderlinePosition()
        rootView.tableView.reloadData()
        
    }
    
    
    //MARK:- Set RootView
    lazy var rootView : AppointmentsRootView = {
        let view  = AppointmentsRootView()
        return view
    }()
    
    //MARK:- Properties
    
    lazy var rowsTodisplay : [Appointmensts] = todayAppointmentsInfo
    
    //MARK:- Get Appointments Info API
    func getAppointmentsInfo(){
        showLoader()
        GetAppointments().fetchInfo {[weak self] info in
           
            DispatchQueue.main.async {
                guard let self = self else{
                    return
                }
                guard let response = info else {
                    return
                }
                
                if response.success == true{
                    self.stopLoader()
                    if let allAppointments = response.data?.allAppointments{
                        
                        for item in allAppointments{
                            let appointInfo = Appointmensts(appointmentID: item.appointmentID, appointmentDate: item.appointmentDate, weekID: item.weekID, visitType: item.visitType, notes: item.notes)
                            
                            self.allAppointmentsInfo.append(appointInfo)
                        }
                    }
                    
                    if let todaysAppointments = response.data?.todaysAppointments{
                        for item in todaysAppointments{
                            let appointInfo = Appointmensts(appointmentID: item.appointmentID, appointmentDate: item.appointmentDate, weekID: item.weekID, visitType: item.visitType, notes: item.notes)
                            
                            if let lat = item.lat, let lng = item.lng {
                                let coordinates =  CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                self.appoitmentsLocations.append(coordinates)
                            }
                            self.todayAppointmentsInfo.append(appointInfo)
                            
                            
                        }
                    }
                    self.setupTblView()
                    self.rootView.tableView.reloadData()
                }else{
                    self.stopLoader()
                    self.showToastMessage(with: response.message ?? "Error Occured")
                }
            }
        }
    }
}

extension AppointmentsController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowsTodisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tblViewCellId, for: indexPath) as? AppointmentsCell else{
            return UITableViewCell()
        }
        cell.fillInfo(with: rowsTodisplay[indexPath.row])
        cell.delegate = self

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 550.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 110
    }
    
}

extension AppointmentsController : AppointmentsCellDelegate{
    func didTapOnCell(with info: DetailAppointmentInfo) {
        Log.echo(key: TAG, text: "Appointment Id and Week Id : \(info)")
    
        let vc = AppointmentDetailController(with: info)
            self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension AppointmentsController : DeatailedTrackInfoDelegate {
    func showWayPoints() {
        let controller = DetailedRoutesController(locations: self.appoitmentsLocations)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

