//
//  AppointmentsDetailRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 16/08/21.
//

import Foundation
import UIKit
import SDWebImage
import CoreLocation

class AppointmentsDetailRootView: ExtendedView {
    
    
    let TAG = "AppointmentsDetailRootView"
    var controller : DetailAppointmentController?
    var delegate : AppointmentsDetailDelagate?
    var stackViewItems = [UIView]()
//    var userAppntId : Int?
    var patientName : String?
    var userLocation : CLLocationCoordinate2D?
    
    var cancelBtnheightAnchor : NSLayoutConstraint?
    var completeAppointmentHeightAnchor : NSLayoutConstraint?
    var licenseNumberHeightAnchor :NSLayoutConstraint?
    var staffTypeHeightAnchor : NSLayoutConstraint?
    
    var genderHeightAnhor : NSLayoutConstraint?
    var preferLanHeighTAnchor : NSLayoutConstraint?
    
    var respactiveRoleToCall = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLayout() {
        super.viewDidLayout()
        getRoleTypeToCall()
        setupViews()
        layoutUI()
        setupStacViews()
        
        backgroundColor = .white
    }
    
    func getRoleTypeToCall(){
        if let role = SignedUserInfo.sharedInstance?.role {
            if role == .doctor{
                self.respactiveRoleToCall = "Patient"
            }else{
                self.respactiveRoleToCall = "Doctor"
            }
        }
    }
    
    
    func fillInfo(with info : AppointmentDetailResponse?){
        
        guard let userInfo = info?.data else{
            return
        }
        DispatchQueue.main.async {
            self.addressField.infoTxtField.text = SignedUserInfo.sharedInstance?.role == .doctor ? userInfo.patientAddress : userInfo.staffAddress
            self.staffName.infoTxtField.text = SignedUserInfo.sharedInstance?.role == .doctor ? userInfo.patientName : userInfo.staffName
            self.licenseNumber.infoTxtField.text = userInfo.staffLicenseNumber
            self.staffEmail.infoTxtField.text = SignedUserInfo.sharedInstance?.role == .doctor ? userInfo.patientEmail : userInfo.staffEmail
            self.staffType.infoTxtField.text = userInfo.staffType
            self.visitType.infoTxtField.text = userInfo.visitType
            self.notesInfo.infoTxtField.text = userInfo.notes
            self.appointmentStatus.infoTxtField.text = userInfo.appointmentStatus
            self.genderfield.infoTxtField.text = userInfo.patientGender
            self.dateOfBirthfield.infoTxtField.text = DateParser.convertTimeStampToDesiredDateFormat(userInfo.patientDob ?? Int())
            self.languagefield.infoTxtField.text = userInfo.patientPreferredLanguage
            self.phoneNumberField.infoTxtField.text = SignedUserInfo.sharedInstance?.role == .doctor ? userInfo.patientPhone?.formatMobileNumber() : userInfo.staffPhone?.formatMobileNumber()
            self.controller?.stopLoader()
            self.downLodProfileImg(with: SignedUserInfo.sharedInstance?.role == .doctor ? userInfo.patientImage ?? "" : userInfo.staffImage ?? "")
//            self.userAppntId = info?.data?.appointmentID
            self.patientName = userInfo.patientName
            if userInfo.appointmentStatus == DoctorNavigationStatus.cancelledRequested.rawValue{
                self.updateCancelAppointmentStatus()
            }
            
            self.userLocation = CLLocationCoordinate2D(latitude: userInfo.patientLatitude ?? 0.0, longitude: userInfo.patientLongitude ?? 0.0)
            
        }
    }
    
    
    func setupStacViews(){
        if SignedUserInfo.sharedInstance?.role == .doctor{
            cancelBtnheightAnchor?.constant = 0
            licenseNumberHeightAnchor?.constant = 0
            staffTypeHeightAnchor?.constant = 0
            licenseNumber.isHidden = true
            staffType.isHidden = true
            cancelAppointmentBtn.isHidden = true
            stackView.removeArrangedSubview(tracktBtn)
            tracktBtn.removeFromSuperview()
        }else{
            genderHeightAnhor?.constant = 0
            completeAppointmentHeightAnchor?.constant = 0
            preferLanHeighTAnchor?.constant = 0

            genderfield.isHidden = true
            languagefield.isHidden = true
            stackView.removeArrangedSubview(getToPatientBtn)
            getToPatientBtn.removeFromSuperview()
        }
        layoutIfNeeded()
    }
    
    func downLodProfileImg(with url : String) {
        
        guard let url = URL(string: url) else {
            return
        }

        SDWebImageDownloader().downloadImage(with: url) { [weak self] image, data, error, success in
            guard let self = self else {return}
            
            if success && error == nil {
                Log.echo(key: self.TAG, text: image?.size)
                self.profileImg.image = image
                return
            }else{
                Log.echo(key: "ERROR!!", text: error?.localizedDescription)
                self.profileImg.image = #imageLiteral(resourceName: "dummyProfile")
            }
        }
    }
    
    //MARK: - Properties
    lazy var scrollView: InterfaceScrollView = {
      let scrollView = InterfaceScrollView()
        scrollView.backgroundColor = .clear
      return scrollView
    }()
    
    private lazy var containerView: UIView = {
      let view = UIView()
      view.backgroundColor = .white
      return view
    }()
    
    lazy var profileImg : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "ic_defaultplaceholder")
        iv.layer.cornerRadius = 50
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var appointmentId : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 16)
        return lbl
    }()
    
    lazy var backgrndCurve : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.DarkGreen
        view.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius:60)
        return view
    }()
    
    lazy var basicInfoContainerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.applyShadow(apply: true, color: .lightGray, offset: CGSize(width: 0, height: 10), opacity: 1.2, radius: 10, shadowRect: nil)
        cv.layer.cornerRadius = 6
        return cv
    }()
    
    private lazy var staffName: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "First Name", placeHolder: "First name", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var staffEmail: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Email".localized() ?? "", placeHolder: "Email Address", isRequired: true, image: UIImage(systemName: "mail.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var visitType: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Visit Type", placeHolder: "Visit Type", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var staffType: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Staff Type", placeHolder: "Visit Type", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var appointmentStatus: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Appointment Status".localized() ?? "", placeHolder: "Visit Type", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var notesInfo: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Notes".localized() ?? "", placeHolder: "Notes", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    private lazy var licenseNumber: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "License Number".localized() ?? "", placeHolder: "License Number", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
      return fieldView
    }()
    
    
    lazy var dateOfBirthfield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Date of Birth".localized() ?? "", placeHolder: "YYYY/MM/DD", isRequired: true, image: UIImage(systemName: "calendar")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        pt.isUserInteractionEnabled = false
        return pt
    }()
    
    lazy var genderfield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Gender", placeHolder: "", isRequired: true, image: #imageLiteral(resourceName: "lavatory (1)").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        pt.isUserInteractionEnabled = false
        return pt
    }()
    
    lazy var languagefield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Prefered Language".localized() ?? "", placeHolder: "", isRequired: true, image: UIImage(systemName: "calendar")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        pt.isUserInteractionEnabled = false
        return pt
    }()
    
    lazy var addressField: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Address".localized() ?? "", placeHolder: "Address", isRequired: true, image: #imageLiteral(resourceName: "address").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller ?? InterfaceExtendedController())
        fieldView.isUserInteractionEnabled = false
     return fieldView
   }()
    
    lazy var phoneNumberField : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Phone".localized() ?? "", placeHolder: "", isRequired: true, image: UIImage(systemName: "phone")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        pt.isUserInteractionEnabled = false
        return pt
    }()
    
    lazy var getToPatientBtn : SideImageWithButton = {
        let btn = SideImageWithButton(with: #imageLiteral(resourceName: "ic_navigation"), title: "Navigate")
        btn.backgroundColor = .red
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.layer.cornerRadius = 25
        btn.btn.addTarget(self, action: #selector(didtapOnGetToPatient), for: .touchUpInside)
        return btn
    }()
    
    lazy var callPatientBtn : SideImageWithButton = {
       
        let btn = SideImageWithButton(with: #imageLiteral(resourceName: "ic_phone_white"), title: "  Call   ")
        btn.backgroundColor = .red
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.layer.cornerRadius = 25
        btn.btn.addTarget(self, action: #selector(didtapOnCallToPatient), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelAppointmentBtn : SideImageWithButton = {
        let btn = SideImageWithButton(with: #imageLiteral(resourceName: "ic_cancel").withTintColor((UIColor(hexString: "#840010")), renderingMode: .alwaysOriginal), title: "Cancel Appointment")
        btn.btn.tintColor = UIColor(hexString: "#840010")
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor(hexString: "#840010").cgColor
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 25
        btn.btn.addTarget(self, action: #selector(didtapOnCancelAppointment), for: .touchUpInside)
        return btn
    }()
    
    lazy var tracktBtn : SideImageWithButton = {
        let btn = SideImageWithButton(with: #imageLiteral(resourceName: "ic_navigation"), title: "Track Doctor".localized() ?? "")
        btn.backgroundColor = .red
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    lazy var completeAppointmentBtn : SideImageWithButton = {
        let btn = SideImageWithButton(with: #imageLiteral(resourceName: "ic_navigation"), title: "Mark Appointment As Complete".localized() ?? "")
        btn.backgroundColor = .red
        btn.backgroundColor = AppThemeConfig.DarkGreen
        btn.btn.addTarget(self, action: #selector(didtapOnCompleteAppointment), for: .touchUpInside)
        btn.layer.cornerRadius = 25
        return btn
    }()
    
    
    lazy var stackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [getToPatientBtn,tracktBtn,callPatientBtn])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 2.5
        return view
    }()
    
    

    //MARK: - Actions
    @objc func didtapOnGetToPatient(){
        //Dummy location
//        let pat = CLLocationCoordinate2D(latitude: 19.0366, longitude: 72.8601)
        
        guard let pat = userLocation else {return}
        
        let vc = DoctorTrackingController(with: pat)
        vc.appointmentId = controller?.appointment_id
        vc.patientName = self.patientName
        controller?.navigationController?.pushViewController(vc, animated: true)
//        controller?.openGoogleNavigationApp(withLocation: pat)
    }
    
    @objc func didtapOnCallToPatient(){
        
        let number = phoneNumberField.infoTxtField.text
        
        let phoneUrl = URL(string: "telprompt:\(number ?? "")")
        if let phoneUrl = phoneUrl {
            print("phoneUrl  --> \(phoneUrl)")
        }
        if let phoneUrl = phoneUrl {
            if UIApplication.shared.canOpenURL(phoneUrl) {
                UIApplication.shared.openURL(phoneUrl)
            }
        }
    }
    
    @objc func didtapOnCancelAppointment(){
        Log.echo(key: TAG, text: "CANCEL BTN TAPPED!")
        let vc = CancelAppointmentController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        vc.rootView.deleate = self
        controller?.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @objc func didtapOnCompleteAppointment(){
        Log.echo(key: "abhi", text: "Appointment marked as DONE! tapped")
        
        controller?.showLoader()
        RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: "Are you sure you want to mark this appointment as complete?", successTitle: "Yes", rejectTitle: "No", showCancel: true, completion: {[weak self] success in
            DispatchQueue.main.async {
                guard let weakSelf = self else{return}
                weakSelf.controller?.stopLoader()
                if success == true{
                  
                    weakSelf.controller?.completeAppointment()
                }
            }
            
        })
            
    }
    
//    func completeAppointment(){
//        let request  = EnrouteStatusRequest(appointment_id: self.userAppntId,status: .completed)
//            EnrouteStatusService().updateInfo(for: request) {
//                DispatchQueue.main.async {
//                    self.controller?.stopLoader()
//                    RootControllerManager().updateRoot()
//                }
//            }
//    }
    
    
    
    //MARK: - SetupView
    func setupViews(){
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backgrndCurve)
        containerView.addSubview(basicInfoContainerView)
        containerView.addSubview(profileImg)
        basicInfoContainerView.addSubview(staffName)
        basicInfoContainerView.addSubview(appointmentStatus)
        basicInfoContainerView.addSubview(genderfield)
        basicInfoContainerView.addSubview(staffEmail)
        basicInfoContainerView.addSubview(visitType)
        basicInfoContainerView.addSubview(notesInfo)
        basicInfoContainerView.addSubview(licenseNumber)
        basicInfoContainerView.addSubview(staffType)
        basicInfoContainerView.addSubview(phoneNumberField)
        basicInfoContainerView.addSubview(addressField)
        basicInfoContainerView.addSubview(dateOfBirthfield)
        basicInfoContainerView.addSubview(languagefield)
        containerView.addSubview(stackView)
        containerView.addSubview(cancelAppointmentBtn)
        containerView.addSubview(completeAppointmentBtn)
    }
    //MARK:- LayoutUI
    func layoutUI(){
        
        _ = scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
         
         
         _ = containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        _ = backgrndCurve.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor)
        
        backgrndCurve.heightEqualToView(self, multiplier: 0.3)
        
        _ = profileImg.anchor(top: backgrndCurve.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0),size: .init(width: 100, height: 100))
        profileImg.centerX(inView: self)
        
        
        _ = basicInfoContainerView.anchor(top: profileImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        
        _ = staffName.anchor(top: basicInfoContainerView.topAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        _  = staffEmail.anchor(top: staffName.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        _ = staffType.anchor(top: staffEmail.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15))
        
        staffTypeHeightAnchor = staffType.heightAnchor.constraint(equalToConstant: 70)
        staffTypeHeightAnchor?.isActive = true
        
        _  = notesInfo.anchor(top: staffType.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        _ = appointmentStatus.anchor(top: notesInfo.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        licenseNumberHeightAnchor  = licenseNumber.anchor(top: appointmentStatus.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70)).last
        
        
        genderHeightAnhor = genderfield.anchor(top: licenseNumber.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70)).last
        
        _ = phoneNumberField.anchor(top: genderfield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        _ = dateOfBirthfield.anchor(top: phoneNumberField.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        preferLanHeighTAnchor = languagefield.anchor(top: dateOfBirthfield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70)).last
        
        _ = addressField.anchor(top: languagefield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: basicInfoContainerView.bottomAnchor, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 20, right: 15),size: .init(width: 0, height: 70))
        
        _ = stackView.anchor(top: basicInfoContainerView.bottomAnchor, leading: basicInfoContainerView.leadingAnchor , bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 30, right: 0),size: .init(width: 0, height: 50))
        
        cancelBtnheightAnchor = cancelAppointmentBtn.anchor(top: stackView.bottomAnchor, leading: stackView.leadingAnchor, bottom: nil, trailing: stackView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 30, right: 0),size: .init(width: 0, height: 50)).last
        
        completeAppointmentHeightAnchor = completeAppointmentBtn.anchor(top: cancelAppointmentBtn.bottomAnchor, leading: stackView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: stackView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 30, right: 0),size: .init(width: 0, height: 50)).last
    }
   
}

extension AppointmentsDetailRootView : CancelAppointmentDelegate{
    
    func appointmentDidGotCancel(with reason: String) {
        let request = CancelRequest(appointment_id: (controller?.appointment_id), reason: reason)
        CancelService().updateInfo(for: request) { response in
            DispatchQueue.main.async {
                if response?.success == true{
                    self.updateCancelAppointmentStatus()
                }else{
                    self.controller?.alert(withTitle: AppInfoConfig.appName, message: response?.message ?? "Error Occured", successTitle: "Ok", rejectTitle: "", showCancel: false, completion: nil)
                }
            }
        }

    }
    
    func updateCancelAppointmentStatus(){
        DispatchQueue.main.async {
            self.cancelAppointmentBtn.btn.setTitle("Cancellation Requested", for: .normal)
            self.cancelAppointmentBtn.img.image = UIImage()
            self.cancelAppointmentBtn.backgroundColor = .lightGray
            self.cancelAppointmentBtn.isUserInteractionEnabled = false
            self.cancelAppointmentBtn.btn.tintColor = .darkGray
            self.cancelAppointmentBtn.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

extension UIButton {
  func imageToRight() {
      transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
      titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
      imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
  }
}

