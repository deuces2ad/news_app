//
//  ParentAppointmentController.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 15/09/21.
//

import Foundation
import UIKit
import CoreLocation

class ParentAppointmentController: InterfaceExtendedController {
   
    let TAG = "AppointmentsController"
    let tblViewCellId = "cell"
    
    var allAppointmentsInfo = [Appointmensts]()
    var todayAppointmentsInfo = [Appointmensts]()
    var appoitmentsLocations = [CLLocationCoordinate2D]()
    var delegate : DeatailedTrackInfoDelegate?
    let refreshControl = UIRefreshControl()
    var patientCellListner : ((DetailAppointmentInfo)->Void)?
    var doctorCellListner : (()->Void)?
    
    //MARK:- LifeCycle
    
    override func loadView() {
        super.loadView()
        view = rootView
        rootView.controller = self
        
    }
    
    //MARK:- Intialization
    func intializeVariable(){
        paintInterface()
        setupPullToRefresh()
        getAppointmentsInfo()
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
    
    fileprivate func setupPullToRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        rootView.tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
     func handleSeletionOfTabs(){
        Log.echo(key: "aa", text: "Tapped!!")
        let selectedIndex = rootView.menuBar.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            rowsTodisplay = todayAppointmentsInfo
            rootView.detailedTrackBottomAnchor?.constant = UIDevice.current.userInterfaceIdiom == .pad ? -100 : -120
            todayAppointmentsInfo.isEmpty ? rootView.showNoAppointmentMessage() : rootView.hideNoAppointmentMessage()
        case 1:
            rowsTodisplay = allAppointmentsInfo
            rootView.detailedTrackBottomAnchor?.constant = UIDevice.current.userInterfaceIdiom == .pad ? 80 : 60
            allAppointmentsInfo.isEmpty ? rootView.showNoAppointmentMessage() : rootView.hideNoAppointmentMessage()
        default: break
            
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        rootView.menuBar.changeUnderlinePosition()
         
         
        rootView.tableView.reloadData()
        
    }
    
    
    //MARK: - Set RootView
    lazy var rootView : AppointmentsRootView = {
        let view  = AppointmentsRootView()
        return view
    }()
    
     // MARK: - Objc functions
    
    @objc func refresh(_ sender: AnyObject) {
        Log.echo(key: TAG, text: "")
        getAppointmentsInfo()
    }
    
    //MARK: - Properties
    
    lazy var rowsTodisplay : [Appointmensts] = todayAppointmentsInfo
    
    //MARK: - Get Appointments Info API
    fileprivate func getAppointmentsInfo(){
        self.allAppointmentsInfo.removeAll()
        self.todayAppointmentsInfo.removeAll()
       
        Log.echo(key: TAG, text: "\(allAppointmentsInfo.count)")
        Log.echo(key: TAG, text: "\(todayAppointmentsInfo.count)")
        
        showLoader()
        
        GetAppointments().fetchInfo {[weak self] info in
           
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
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
                            let appointInfo =  Appointmensts(appointmentID: item.appointmentID, appointmentDate: item.appointmentDate, visitType: item.visitType, notes: item.notes,patientName : item.patientName,doctorName:item.staffName, patientLoc: CLLocationCoordinate2D(latitude: item.patientLatitude ?? 0.0, longitude: item.patientLongitude ?? 0.0),status: item.appointmentStatus)
                          
                            self.allAppointmentsInfo.append(appointInfo)
                        }
                        
                    }
                    
                    if let todaysAppointments = response.data?.pendingAppointments{
                        for item in todaysAppointments{
                            let appointInfo = Appointmensts(appointmentID: item.appointmentID, appointmentDate: item.appointmentDate, visitType: item.visitType, notes: item.notes,patientName : item.patientName,doctorName:item.staffName, patientLoc: CLLocationCoordinate2D(latitude: item.patientLatitude ?? 0.0, longitude: item.patientLongitude ?? 0.0),status: item.appointmentStatus)
                            
                            if let lat = item.patientLatitude, let lng = item.patientLongitude {
                                let coordinates =  CLLocationCoordinate2D(latitude: lat, longitude: lng)
                                self.appoitmentsLocations.append(coordinates)
                            }
                            self.todayAppointmentsInfo.append(appointInfo)
                            self.todayAppointmentsInfo.isEmpty ? self.rootView.showNoAppointmentMessage() : self.rootView.hideNoAppointmentMessage()
                        }
                    }
                    self.setupTblView()
                    self.rootView.tableView.reloadData()
                    self.handleSeletionOfTabs()
                }else{
                    self.stopLoader()
                    self.showToastMessage(with: response.message ?? "Error Occured")
                }
            }
        }
    }
}

extension ParentAppointmentController : UITableViewDelegate, UITableViewDataSource{
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

extension ParentAppointmentController : AppointmentsCellDelegate{
    func didTapOnCell(with info: DetailAppointmentInfo) {
        Log.echo(key: TAG, text: "Appointment Id and Week Id : \(info)")
    
    
        if  SignedUserInfo.sharedInstance?.role == .doctor {
            let vc = DoctorAppointmentDetailController(with: info)
            vc.appointment_id = info.apointment_id
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            patientCellListner?(info)
        }
    }
}



