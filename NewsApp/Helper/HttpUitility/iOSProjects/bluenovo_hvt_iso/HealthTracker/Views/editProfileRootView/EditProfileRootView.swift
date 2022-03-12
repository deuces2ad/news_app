//
//  EditProfileRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 31/07/21.
//

import Foundation
import UIKit

class EditProfileRootView: ExtendedView{
    
    
    let TAG = "EditProfileRootView"
    weak var controller : EditProfileController?
    var lincenseNumberFldHt : NSLayoutConstraint?
    var languagedFldHt : NSLayoutConstraint?
    var dateOfBirthfld : NSLayoutConstraint?
   
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        backgroundColor = AppThemeConfig.DarkGreen
     
        setupView()
        layoutUI()
        handleFieldsAvailbilty()
        paintInterface()
        initializeVariable()
    }
    
    fileprivate func initializeVariable(){
    }
   
    fileprivate func paintInterface(){
        profileImg.layer.cornerRadius = 50
        profileImg.clipsToBounds = true
        
    }
    
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
    
    
    //MARK:- Propties
    
    lazy var curvedBckGrnd : UIView = {
        let view = UIView()
        view.backgroundColor = AppThemeConfig.DarkGreen
//        view.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 80)
        view.clipsToBounds = true
        return view
    }()
    
    lazy var profileImg : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profilePicAction(gesture:)))
        iv.addGestureRecognizer(tapGesture)
        iv.isUserInteractionEnabled = true
        iv.image = #imageLiteral(resourceName: "dummyProfile")
        return iv
    }()
    
    lazy var basicInfoContainerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = .white
        cv.applyShadow(apply: true, color: .lightGray, offset: CGSize(width: 0, height: 10), opacity: 1.2, radius: 10, shadowRect: nil)
        cv.layer.cornerRadius = 6
        return cv
    }()
    
    lazy var addressInfoContainerView : UIView = {
        let cv = UIView()
        cv.layer.cornerRadius = 6
        cv.backgroundColor = .white
        cv.applyShadow(apply: true, color: .lightGray, offset: CGSize(width: 0, height: 5), opacity: 1.2, radius: 10, shadowRect: nil)
        cv.layer.masksToBounds = false
        return cv
    }()
    
    lazy var basicInfoHeader : HeaderInfo = {
        let uv = HeaderInfo(header: "  Basic Info  ".localized() ?? "")
        return uv
    }()
    
    
    private lazy var nameField: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "First Name".localized() ?? "", placeHolder: "First name", isRequired: true, image: UIImage(systemName: "person.fill")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
       
      return fieldView
    }()
    

     lazy var emailField: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Email".localized() ?? "", placeHolder: "abc@xyz.com", isRequired: true, image: UIImage(named: "email_icon")?.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal) ?? UIImage(), textFiledDelegate: self.controller ?? InterfaceExtendedController())
      return fieldView
    }()
    
    
    
    lazy var phonefield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Phone".localized() ?? "", placeHolder: "Phone Number", isRequired: true, image: UIImage(systemName: "phone")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var dateOfBirthfield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Date of Birth".localized() ?? "", placeHolder: "YYYY/MM/DD", isRequired: true, image: UIImage(systemName: "calendar")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var genderfield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Gender".localized() ?? "", placeHolder: "", isRequired: true, image: #imageLiteral(resourceName: "lavatory (1)").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var languagefield : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Prefered Language".localized() ?? "", placeHolder: "", isRequired: true, image: UIImage(systemName: "calendar")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var licenseNumberFld : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "License Number".localized() ?? "", placeHolder: "", isRequired: true, image: UIImage(systemName: "calendar")!.withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    
    
    lazy var addressHeaderInfo : HeaderInfo = {
        let hv = HeaderInfo(header: " Address ".localized() ?? "")
        return hv
    }()
    
    lazy var addressField: PersonalInfoTextFieldView = {
        let fieldView = PersonalInfoTextFieldView(header: "Address".localized() ?? "", placeHolder: "Address", isRequired: true, image: #imageLiteral(resourceName: "address").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller ?? InterfaceExtendedController())
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getLocalAddresss(gesture:)))
       fieldView.infoTxtField.isUserInteractionEnabled = false
       fieldView.addGestureRecognizer(tapGesture)
     return fieldView
   }()
    
    lazy var stateField : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "State".localized() ?? "", placeHolder: "", isRequired: true, image: #imageLiteral(resourceName: "address").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var cityField : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "City".localized() ?? "", placeHolder: "", isRequired: true, image: #imageLiteral(resourceName: "address").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var zipCode : PersonalInfoTextFieldView = {
        let pt = PersonalInfoTextFieldView(header: "Zipcode".localized() ?? "", placeHolder: "", isRequired: true, image: #imageLiteral(resourceName: "address").withTintColor(AppThemeConfig.LightGreen, renderingMode: .alwaysOriginal), textFiledDelegate: self.controller!)
        return pt
    }()
    
    lazy var userTypeInfoLbl : UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = .white
        lbl.text = "Hey,User\nAbhishek Dhiman"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 14)
        return lbl
    }()
    
    
    lazy var saveBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("EDIT", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
        btn.layer.cornerRadius = 12
        self.disableTextfld()
        return btn
    }()
    

    
    

    //MARK: - Actions
    
    @objc func profilePicAction(gesture: UITapGestureRecognizer){
        Log.echo(key: TAG, text: "PROFILE PIC TAPPED!")
        controller?.showImagePicker()
    }
    
    @objc func saveBtnAction(){
        Log.echo(key: TAG, text: "PROFILE PIC TAPPED!")
//        controller?.saveChnages()
        toggleBtnAction()
        if saveBtn.titleLabel?.text == "SAVE"{
            disableTextfld()
        }else{
            enableTextfld()
        }
    }
    
    //MARK: - Fill userInfo
    func fillInfo(with info : SignedUserInfo?){
        
        guard let rawInfo = info else{
            return
        }
        
        
        let userType = rawInfo.role.rawValue.localized() ?? ""
        DispatchQueue.main.async {
            if let myName = rawInfo.name  {
                let userName = myName
                let rawUserInfo = "Hello,".localized()! + " \(String(describing: userType))\n\(String(describing: userName))"
                self.userTypeInfoLbl.text = rawUserInfo
            }
            if let phone = rawInfo.phone  {
                self.phonefield.infoTxtField.text = "\(phone)".formatMobileNumber()
            }
            
            self.emailField.infoTxtField.text = rawInfo.email
            self.dateOfBirthfield.infoTxtField.text = DateParser.convertTimeStampToDesiredDateFormat(rawInfo.dob ?? Int())
            self.genderfield.infoTxtField.text = rawInfo.genderType.rawValue
            self.addressField.infoTxtField.text = rawInfo.address
            self.stateField.infoTxtField.text = rawInfo.state
            self.zipCode.infoTxtField.text = rawInfo.zipcode
            self.licenseNumberFld.infoTxtField.text = rawInfo.licenseNumber
            self.languagefield.infoTxtField.text = rawInfo.preferredLanguage
            self.cityField.infoTxtField.text = rawInfo.city
            
        }
    }
    
    fileprivate func enableTextfld(){
        emailField.isUserInteractionEnabled = true
        emailField.infoTxtField.backgroundColor = .clear
        
        phonefield.isUserInteractionEnabled = true
        phonefield.infoTxtField.backgroundColor = .clear
        
        dateOfBirthfield.isUserInteractionEnabled = true
        dateOfBirthfield.infoTxtField.backgroundColor = .clear
        
        genderfield.isUserInteractionEnabled = true
        genderfield.infoTxtField.backgroundColor = .clear
        
        languagefield.isUserInteractionEnabled = true
        languagefield.infoTxtField.backgroundColor = .clear
        
        addressField.isUserInteractionEnabled = true
        addressField.infoTxtField.backgroundColor = .clear
        
        cityField.isUserInteractionEnabled = true
        cityField.infoTxtField.backgroundColor = .clear
        
        zipCode.isUserInteractionEnabled = true
        zipCode.infoTxtField.backgroundColor = .clear
        
        stateField.isUserInteractionEnabled = true
        stateField.infoTxtField.backgroundColor = .clear
        
        licenseNumberFld.isUserInteractionEnabled = true
        licenseNumberFld.infoTxtField.backgroundColor = .clear
        
    }
    
    fileprivate func disableTextfld(){
        emailField.isUserInteractionEnabled = false
        emailField.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        phonefield.isUserInteractionEnabled = false
        phonefield.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        dateOfBirthfield.isUserInteractionEnabled = false
        dateOfBirthfield.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        genderfield.isUserInteractionEnabled = false
        genderfield.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        languagefield.isUserInteractionEnabled = false
        languagefield.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        addressField.isUserInteractionEnabled = false
        addressField.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        cityField.isUserInteractionEnabled = false
        cityField.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        zipCode.isUserInteractionEnabled = false
        zipCode.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        stateField.isUserInteractionEnabled = false
        stateField.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
        
        licenseNumberFld.isUserInteractionEnabled = false
        licenseNumberFld.infoTxtField.backgroundColor = UIColor(hexString: "#d3d3d3")
    }

    func toggleBtnAction(){
        switch saveBtn.titleLabel?.text {
        case "SAVE":
            return saveBtn.setTitle("EDIT", for: .normal)
        default:
            return saveBtn.setTitle("SAVE", for: .normal)
        }
       
    }
    
    
    @objc func getLocalAddresss(gesture: UITapGestureRecognizer){
        Log.echo(key: TAG, text: "GET LOCAL ADDRESS TAPPED")
        guard let controller = self.controller else{
            return
        }
        let fetchAddressController = FetchAddressController()
        fetchAddressController.rootView.fetchAdressControllerDelegate = self
        controller.navigationController?.pushViewController(fetchAddressController, animated: true)
    }
    
    
    fileprivate func setupView(){
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(curvedBckGrnd)
        curvedBckGrnd.addSubview(userTypeInfoLbl)
//        curvedBckGrnd.addSubview(saveBtn)
        containerView.addSubview(profileImg)
        
        containerView.addSubview(basicInfoContainerView)
        
        basicInfoContainerView.addSubview(basicInfoHeader)
        basicInfoContainerView.addSubview(emailField)
        basicInfoContainerView.addSubview(phonefield)
        basicInfoContainerView.addSubview(dateOfBirthfield)
        basicInfoContainerView.addSubview(genderfield)
        basicInfoContainerView.addSubview(languagefield)
        basicInfoContainerView.addSubview(licenseNumberFld)
        
        containerView.addSubview(addressInfoContainerView)
        addressInfoContainerView.addSubview(addressHeaderInfo)
        addressInfoContainerView.addSubview(addressField)
        addressInfoContainerView.addSubview(stateField)
        addressInfoContainerView.addSubview(cityField)
        addressInfoContainerView.addSubview(zipCode)
        
    }
    
    fileprivate func layoutUI(){
        
        _ = scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
        
        
        _ = containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        _ = profileImg.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0),size: .init(width: 100, height: 100))
        
        _ = userTypeInfoLbl.anchor(top: nil, leading: profileImg.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 10, bottom: 0, right: 0),size: .init(width: 0, height: 60))
        userTypeInfoLbl.centerY(inView: profileImg)
        
//        _ = saveBtn.anchor(top: profileImg.topAnchor, leading: nil, bottom: nil, trailing: curvedBckGrnd.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 20))
       
        
       _ =  curvedBckGrnd.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: profileImg.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: -80, right: 0))
        
        _ = basicInfoContainerView.anchor(top: curvedBckGrnd.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: -50, left: 20, bottom: 20, right: 20))
        
        _ = basicInfoHeader.anchor(top: basicInfoContainerView.topAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 0, right: 15),size: .init(width: 0, height: 30))
        
        _ = emailField.anchor(top: basicInfoHeader.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70))
        
        _ = phonefield.anchor(top: emailField.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70))
        
        dateOfBirthfld = dateOfBirthfield.anchor(top: phonefield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70)).last
        
        _ = genderfield.anchor(top: dateOfBirthfield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70))
        
        
        languagedFldHt = languagefield.anchor(top: genderfield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: nil, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70)).last
        
        
        lincenseNumberFldHt = licenseNumberFld.anchor(top: languagefield.bottomAnchor, leading: basicInfoContainerView.leadingAnchor, bottom: basicInfoContainerView.bottomAnchor, trailing: basicInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70)).last
     
    
        
       _ = addressInfoContainerView.anchor(top: basicInfoContainerView.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 20, bottom: 20, right: 20))
       
        
        _ = addressHeaderInfo.anchor(top: addressInfoContainerView.topAnchor, leading: addressInfoContainerView.leadingAnchor, bottom: nil, trailing: addressInfoContainerView.trailingAnchor,padding: .init(top: 5, left: 15, bottom: 0, right: 15),size: .init(width: 0, height: 30))
        
        
        _ = addressField.anchor(top: addressHeaderInfo.bottomAnchor, leading: addressInfoContainerView.leadingAnchor, bottom: nil, trailing: addressInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 70))
        
        _ = stateField.anchor(top: addressField.bottomAnchor, leading: addressInfoContainerView.leadingAnchor, bottom: nil, trailing: addressInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 70))
        
        _ = cityField.anchor(top: stateField.bottomAnchor, leading: addressInfoContainerView.leadingAnchor, bottom: nil, trailing: addressInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20),size: .init(width: 0, height: 70))

        _ = zipCode.anchor(top: cityField.bottomAnchor, leading: addressInfoContainerView.leadingAnchor, bottom: addressInfoContainerView.bottomAnchor, trailing: addressInfoContainerView.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 5, right: 20),size: .init(width: 0, height: 70))
        
    }
    
    fileprivate func handleFieldsAvailbilty(){
        guard let role = SignedUserInfo.sharedInstance?.role else{
            return
        }
        
        if role == .doctor{
            self.languagedFldHt?.constant = 0
            self.dateOfBirthfld?.constant = 0
            dateOfBirthfield.isHidden = true
            languagefield.isHidden = true
        }else{
            self.lincenseNumberFldHt?.constant = 0
            licenseNumberFld.isHidden = true
        }
        layoutIfNeeded()
    }
    
}

extension EditProfileRootView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.addressField.infoTxtField{
            return false
        }
        return true
    }
}
extension EditProfileRootView : FetchAdressControllerDelegate{
    func didReceiveLocation(with address: String) {
        addressField.infoTxtField.text = address
    }
    
    
}
