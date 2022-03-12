//
//  FutureAppointmentsController.swift
//  HealthTracker
//
//  Created by Apple on 19/11/21.
//

import Foundation
import UIKit
import CoreMedia
import Network

class FutureAppointmentsController : InterfaceExtendedController {
    
    let TAG = "FutureAppointmentsController"
    

    var appointmentsInfoArr = [AllAppointment]()
    var rawFromData : Date?
    var rawToDate : Date?
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intializeVariable()
        registerListenrs()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    //MARK: - Set RootView
    lazy var rootView : FutureAppointmentsRootView = {
        let rootView = FutureAppointmentsRootView()
        rootView.controller = self
        return rootView
    }()
    
    func intializeVariable(){
        paintInterface()
        getAppointmentDate()
        registerTblView()
    }
    
    func registerTblView(){
        rootView.tblView.delegate = self
        rootView.tblView.dataSource = self
        rootView.tblView.register(AppointmentsCell.self, forCellReuseIdentifier: "cell")
        if #available(iOS 15.0, *) {
            rootView.tblView.sectionHeaderTopPadding = 0
        }
        rootView.tblView.estimatedRowHeight = 88
        rootView.tblView.rowHeight = UITableView.automaticDimension
    }
    
    func paintInterface(){
        setPreselctedDates()
        paintBackButton()
        paintNavigationTitle(text: "Future Appointments")
    }
    
    func registerListenrs(){
        showDateRangePicker()
    }
    
    
    func showDateRangePicker(){
        rootView.getDatesListener = {
            Log.echo(key: self.TAG, text: "didTapOnGetRange")
            let datePicker = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
            datePicker.delegate = self
            datePicker.minimumDate = Date()
            datePicker.maximumDate = Calendar.current.date(byAdding: .month, value: 01, to: Date())
            datePicker.selectedColor = AppThemeConfig.LightGreen
           
         
            self.navigationController?.pushViewController(datePicker, animated: true)
        }
    }
    
    func setPreselctedDates(){
       let preSelectedStartData = DateParser.dateToString(Date())
        let preSelectedEndData = DateParser.dateToString(Calendar.current.date(byAdding: .day, value: 14, to: Date())!)
        
        Log.echo(key: "preSelectedStartData", text: "\(preSelectedStartData)")
        Log.echo(key: "preSelectedEndData", text: "\(preSelectedEndData)")
        self.rootView.fromDateLbl.text = preSelectedStartData
        self.rootView.toDateLbl.text = preSelectedEndData
    }
    
    func fethcAppointmentsInfo(){
        rootView.getAppointmentListner = {
            self.getAppointmentDate()
        }
    }
    
    // MARK: - AppooinmentService
    func getAppointmentDate(){
        self.showLoader()
        self.appointmentsInfoArr.removeAll()
        guard let fromDate = rootView.fromDateLbl.text,
              let toData = rootView.toDateLbl.text else {
                  Log.echo(key: TAG, text: "DINT GET THE DATE THE RANAGE!!!")
                  return
              }
        
        let request = FutureAppointmentsRequest(fromDate: fromDate, toDate: toData)
        
        FutureAppointmentsService().getAppointmentsData(with: request) {(data) in
          
            if data != nil{
               
                Log.echo(key: self.TAG, text: data)
                if let appointmentsData = data?.data?.allAppointments{
                    self.appointmentsInfoArr = appointmentsData
                    if appointmentsData.isEmpty{
                        self.rootView.emptyWindowView.isHidden = false
                        return
                    }
                }else{
                    DispatchQueue.main.async {
                        self.rootView.emptyWindowView.isHidden = false
                        
                    }
                }
                DispatchQueue.main.async {
                    self.stopLoader()
                    self.rootView.emptyWindowView.isHidden = true
                    self.rootView.tblView.reloadData()
                }
            }
        }
    }
}




//MARK: - CalenderDateRange Delegate Methhods.
extension FutureAppointmentsController : CalendarDateRangePickerViewControllerDelegate{
    
    func didCancelPickingDateRange() {
        Log.echo(key: self.TAG, text: "didCancelPickingDateRange")
        self.navigationController?.popViewController(animated: true)
    }
    
    func didPickDateRange(startDate: Date!, endDate: Date!) {
        let formatedStartDate = DateParser.dateToString(startDate)
        let formatedEndDate = DateParser.dateToString(endDate)
        
        Log.echo(key: self.TAG, text: formatedEndDate)
        rootView.fromDateLbl.text = formatedStartDate
        rootView.toDateLbl.text = formatedEndDate
        self.rawFromData = startDate
        self.rawToDate = endDate
        self.getAppointmentDate()
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - TableView Delegate
extension  FutureAppointmentsController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (appointmentsInfoArr[section].appointments!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionIndexPath = indexPath.section
        let itemIndexPath = indexPath.row
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AppointmentsCell{
            
            if appointmentsInfoArr.count > sectionIndexPath  {
                if let infoArr = appointmentsInfoArr[sectionIndexPath].appointments{
                    if itemIndexPath < infoArr.count {
                        cell.fillInfoForFutureAppointment(with: infoArr[itemIndexPath])
                        cell.isFutureAppoint = true
                        cell.delegate = self
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return appointmentsInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = FutureHeaderView(frame: CGRect(x: 0, y: 0, width: rootView.tblView.frame.width, height: 40))
        if let date = appointmentsInfoArr[section].date{
            headerView.headerLbl.text = DateParser.convertTimeStampToDesiredDateFormat(date)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 550.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
}

extension FutureAppointmentsController : AppointmentsCellDelegate{
    func didTapOnCell(with info: DetailAppointmentInfo) {
        Log.echo(key: TAG, text: "Appointment Id and Week Id : \(info)")
        if  SignedUserInfo.sharedInstance?.role == .doctor {
            let vc = DoctorAppointmentDetailController(with: info)
            vc.appointment_id = info.apointment_id
            vc.rootView.getToPatientBtn.btn.isEnabled = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



