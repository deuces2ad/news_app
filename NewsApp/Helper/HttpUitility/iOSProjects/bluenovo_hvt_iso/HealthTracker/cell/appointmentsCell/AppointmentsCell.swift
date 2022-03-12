//
//  AppointmentsCell.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 14/08/21.
//

import Foundation
import UIKit
import CoreLocation


class AppointmentsCell: ExtendedTableCell {
    
    var delegate : AppointmentsCellDelegate?
    var appointmentId : Int?
    var patientLoc : CLLocationCoordinate2D?
    var isFutureAppoint = false
    
    let TAG = "AppointmentsCell"
    
    override func viewDidLayout() {
        super.viewDidLayout()
        backgroundColor = .clear
        setupLayout()
        layoutUI()
        checkIfFutureAppointment()
    }
    
    func checkIfFutureAppointment(){
        if isFutureAppoint{
            dateLbl.widthAnchor.constraint(equalToConstant: 0).isActive = true
            sepratorView.widthAnchor.constraint(equalToConstant: 0).isActive = true
            layoutIfNeeded()
        }
    }
    
    func fillInfo(with data : Appointmensts?){
        
        guard let info = data else {
            return
        }
        self.dateLbl.text = DateParser.convertTimeStampToDesiredDateFormat(info.appointmentDate ?? Int())
        self.visitTypeLbl.text = info.patientName ?? info.doctorName
        self.notesLbl.text = info.notes
        self.appointmentId = info.appointmentID
        self.patientLoc = info.patientLoc
        self.statusLbl.text = "Status : \(info.status ?? "Pending")"
    }
    
    func fillInfoForFutureAppointment(with data : Appointment?){
        
        guard let info = data else {
            return
        }
        self.dateLbl.text = DateParser.convertTimeStampToDesiredDateFormat(info.appointmentDate ?? Int())
        self.visitTypeLbl.text = info.patientName
        self.notesLbl.text = info.notes
        self.appointmentId = info.appointmentID
        self.statusLbl.text = "Status : \(info.appointmentStatus ?? "Pending")"
    }
    
    
    
    //MARK: - Properties
    lazy var containerView : UIView = {
        let uv = UIView()
        uv.backgroundColor = AppThemeConfig.LightGreen
        uv.layer.cornerRadius = 12
        uv.applyShadow(apply: true, color: UIColor(hexString: "#3E4958"), offset: .init(width: -3, height: 4), opacity: 0.4, radius: 3, shadowRect: nil)
        return uv
    }()
    
    
    lazy var dateLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 16)
        lbl.textColor = UIColor(hexString: "#003366")
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var visitTypeLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 18)
        lbl.textColor = AppThemeConfig.DarkGreen
        lbl.numberOfLines = 0
//        lbl.text = "Jordan Winawer"
        return lbl
    }()
    
    lazy var notesLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.text = "Routine Checkup"
        return lbl
    }()
    
    lazy var arrowIndicatorView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "right-arrow.png")
        return iv
    }()
    
    lazy var cellBtnAction : UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(cellbtnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var sepratorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#003366")
        return view
    }()
    
    lazy var statusLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: 14)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.text = "Status : Complete"
        return lbl
    }()
    
    //MARK: - Actions
    
    @objc func cellbtnAction(){
        
        guard  let appointment_id = self.appointmentId else {
            return
        }
        Log.echo(key: TAG, text: "recovered ID is : \(appointment_id) and weekID = \(self.patientLoc)")
        
        let info = DetailAppointmentInfo(apointment_id: appointment_id,latLong: patientLoc)
        self.delegate?.didTapOnCell(with: info)
    }
    
    
    //MARK:- Setup Views
    func setupLayout(){
        addSubview(containerView)
        containerView.addSubview(dateLbl)
        containerView.addSubview(sepratorView)
        containerView.addSubview(visitTypeLbl)
        containerView.addSubview(notesLbl)
        containerView.addSubview(arrowIndicatorView)
        containerView.addSubview(cellBtnAction)
        containerView.addSubview(statusLbl)
    }
    
    //MARK:- layout UI
    func layoutUI(){
        _ = containerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: bottomAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 10, left: 10, bottom:10, right: 10))
        
        _ = dateLbl.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil ,padding: .init(top: 10, left: 10, bottom: 10, right: 0),size: .init(width: 50, height: 60))
        
        _ = sepratorView.anchor(top: dateLbl.topAnchor, leading: dateLbl.trailingAnchor, bottom: dateLbl.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0),size: .init(width: 1, height: 0))
        
        _ = visitTypeLbl.anchor(top: dateLbl.topAnchor, leading: sepratorView.trailingAnchor, bottom: nil, trailing: arrowIndicatorView.trailingAnchor,padding: .init(top: 0, left: 10, bottom: 0, right: 20))
      
        _ = notesLbl.anchor(top: visitTypeLbl.bottomAnchor, leading: visitTypeLbl.leadingAnchor, bottom: nil, trailing: visitTypeLbl.trailingAnchor)
        
        _ = cellBtnAction.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
        
        _ = arrowIndicatorView.anchor(top: nil, leading: visitTypeLbl.trailingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 10),size: .init(width: 50, height: 50))
        arrowIndicatorView.centerY(inView: containerView)
        
        _ = statusLbl.anchor(top: nil, leading: nil, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 10))
        
    }
}
