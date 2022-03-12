//
//  ForgotPasswordRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 22/11/21.
//

enum ForgotPasswordStatus : String{
    case next = "Next"
    case verify = "Verify"
    case reset = "Reset"
}

import Foundation
import UIKit
import AEOTPTextField

class ForgotPasswordRootView : ExtendedView{
    
    let TAG = "ForgotPasswordRootView"
    
    var controller : ForgotPasswordController?
    var currentStatus : ForgotPasswordStatus = .next
    var resetBtnListner : ((ForgotPasswordStatus)-> ())?
    var isOTPsent = false
    var otpCounter = 30
    var timer = Timer()
    var resendStackViewheightAnchor : NSLayoutConstraint?
    
    var discriptionFont : Double {
        return UIDevice.current.userInterfaceIdiom == .pad ? 18 : 17
    }
    
    var forgotpasswordFont : Double {
        return UIDevice.current.userInterfaceIdiom == .pad ? 32 : 17
    }
    
    var lockImgSize : CGSize {
        return UIDevice.current.userInterfaceIdiom == .pad ? CGSize(width: 100, height: 100) : CGSize(width: 50, height: 50)
    }
    
    //MARK: - LifeCycle
    override func viewDidLayout() {
        super.viewDidLayout()
        initilization()
        paintInterface()
        backgroundColor = .white
    }
    
    
    //MARK: - Initailization
    func initilization(){
        setupViews()
        layoutUI()
    }
    
    func paintInterface(){
        disableResetPasswordFields()
        disableOTPField()
        disableResendStackView()
        scrollView.activeField = resendStackView
        self.discriptionTxtLbl.text = "Provide the registered Mobile Number for which you which you want reset password"
    }


    //MARK: - Properties
    
    lazy var scrollView : InterfaceScrollView = {
        let sv = InterfaceScrollView()
        sv.backgroundColor = .white
        return sv
    }()
    
    lazy var containerView : UIView = {
        let sv = UIView()
        sv.backgroundColor = .white
        return sv
    }()
    
    lazy var mobileNumberTxtfld : PersonalInfoTextFieldView = {
        let tf = PersonalInfoTextFieldView(header: "Mobile Number", placeHolder: "Mobile Number", isRequired: true, image: (UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal))!, textFiledDelegate: self.controller!)
        tf.infoTxtField.keyboardType = .numberPad
        tf.backgroundColor = .darkGray.withAlphaComponent(0.2)
        tf.rounded(cornerRadius: 6)
        return tf
    }()
    
    lazy var otpFieldView : PersonalInfoTextFieldView = {
        let tf = PersonalInfoTextFieldView(header: "Enter OTP", placeHolder: "****", isRequired: true, image: (UIImage(systemName: "lock")?.withTintColor(.black, renderingMode: .alwaysOriginal))!, textFiledDelegate: self.controller!)
        tf.infoTxtField.keyboardType = .phonePad
        tf.backgroundColor = .darkGray.withAlphaComponent(0.2)
        tf.rounded(cornerRadius: 6)
        return tf
    }()
    
    lazy var newPassword : PersonalInfoTextFieldView = {
        let tf = PersonalInfoTextFieldView(header: "Enter New Password", placeHolder: "Enter new password", isRequired: true, image: (UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal))!, textFiledDelegate: self.controller!)

        tf.backgroundColor = .darkGray.withAlphaComponent(0.2)
        tf.rounded(cornerRadius: 6)
//        tf.infoTxtField.isSecureTextEntry = true
        return tf
    }()
    
    lazy var confirmPassword : PersonalInfoTextFieldView = {
        let tf = PersonalInfoTextFieldView(header: "Confirm Password", placeHolder: "Confirm Password", isRequired: true, image: (UIImage(systemName: "phone")?.withTintColor(.black, renderingMode: .alwaysOriginal))!, textFiledDelegate: self.controller!)
        tf.backgroundColor = .darkGray.withAlphaComponent(0.2)
        tf.rounded(cornerRadius: 6)
//        tf.infoTxtField.isSecureTextEntry = true
        return tf
    }()
    
    lazy var lockImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_lock")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var forgotPasswordLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: forgotpasswordFont)
        lbl.text = "FORGOT \n PASSWORD"
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        return lbl
    }()
    
    lazy var discriptionTxtLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: AppThemeConfig.defaultFont, size: discriptionFont)
        lbl.text = "bla bla text"
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        lbl.textColor = .lightGray
        return lbl
    }()
    
    lazy var resetBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(ForgotPasswordStatus.next.rawValue, for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.defaultFont, size: 17)
        btn.addTarget(self, action: #selector(didTapOnResetPassword), for: .touchUpInside)
        btn.tintColor = .white
        btn.rounded(cornerRadius: 6)
        btn.backgroundColor = AppThemeConfig.DarkGreen
        return btn
    }()
    
    lazy var stackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [mobileNumberTxtfld,otpFieldView,newPassword,confirmPassword])
        view.axis = .vertical
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
    lazy var resendOtpLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Didn't get the OTP? Resend in (\(otpCounter))"
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: AppThemeConfig.boldFont, size: 15)
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var resendBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Resend OTP", for: .normal)
        btn.titleLabel?.font = UIFont(name: AppThemeConfig.boldFont, size: 15)
        btn.addTarget(self, action: #selector(didTapOnResendOTP), for: .touchUpInside)
        btn.tintColor = .red
        return btn
    }()
    
    lazy var resendStackView : UIStackView = {
        let sv = UIStackView(arrangedSubviews: [resendOtpLbl,resendBtn])
        sv.axis = .vertical
        sv.spacing = 0
        sv.distribution = .fillEqually
        return sv
    }()
    
    //MARK: - Objc functions
    @objc func didTapOnResetPassword(){
        Log.echo(key: TAG, text: "didTapOnResetPassword")
        
        if let listner = resetBtnListner{
            listner(self.currentStatus)
        }
    }
    
    @objc func didStartTimer(){
        if self.otpCounter >= 1{
            self.otpCounter -= 1
            self.resendOtpLbl.text = "Didn't get the OTP ? Resend in (\(otpCounter))"
            resendBtn.isEnabled = false
        }else{
            self.otpCounter = 30
            self.timer.invalidate()
            resendBtn.isEnabled = true
            self.resendOtpLbl.text = "Didn't get the OTP ?"
            
        }
    }
    
    @objc func didTapOnResendOTP(){
        Log.echo(key: TAG, text: "didTap On resend OTP")
        controller?.requestOTPService()
    }

    //MARK: - SetupViews
    func setupViews(){
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(lockImg)
        containerView.addSubview(forgotPasswordLbl)
        containerView.addSubview(discriptionTxtLbl)
        containerView.addSubview(stackView)
        containerView.addSubview(resendStackView)
        containerView.addSubview(resetBtn)
    }
    
    //MARK: - layoutUI
    
    func layoutUI(){
        
        _ = scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        _ = containerView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: containerView.trailingAnchor)
        
        _ = lockImg.anchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0),size:lockImgSize)
        lockImg.centerX(inView: self)
        
        _ = mobileNumberTxtfld.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 70))
        _ = otpFieldView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 70))
        _ = newPassword.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 70))
        _ = confirmPassword.anchor(top: nil, leading: nil, bottom: nil, trailing: nil,size: .init(width: 0, height: 70))
        
        _ = forgotPasswordLbl.anchor(top: lockImg.bottomAnchor, leading: nil, bottom: confirmPassword.bottomAnchor, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        forgotPasswordLbl.centerX(inView: lockImg)
        
        _ = discriptionTxtLbl.anchor(top: forgotPasswordLbl.bottomAnchor, leading:containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 30, bottom: 0, right: 30))
        discriptionTxtLbl.centerX(inView: lockImg)
        
        _ = stackView.anchor(top: discriptionTxtLbl.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor,padding: .init(top: 20, left: 10, bottom: 0, right: 10))
    
        _ = resetBtn.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 20, right: 10), size: .init(width: 0, height: 40))
        
        resendStackViewheightAnchor = resendStackView.anchor(top: resetBtn.bottomAnchor, leading: nil, bottom: containerView.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 30, bottom: 0, right: 30),size: .init(width: 0, height: 50)).last
        resendStackView.centerX(inView: stackView)
        
    }
    
    func disableOTPField(){
        stackView.removeArrangedSubview(otpFieldView)
        otpFieldView.removeFromSuperview()
    }
    
    func enableOTPfield(){
        stackView.addArrangedSubview(otpFieldView)
    }
    
    
    func disableResetPasswordFields(){
        stackView.removeArrangedSubview(newPassword)
        stackView.removeArrangedSubview(confirmPassword)
        newPassword.removeFromSuperview()
        confirmPassword.removeFromSuperview()
    }
    
    func enableResetPasswordFields(){
        stackView.addArrangedSubview(newPassword)
        stackView.addArrangedSubview(confirmPassword)
    }
    
    func disableMobile_OTPfied(){
        stackView.removeArrangedSubview(mobileNumberTxtfld)
        stackView.removeArrangedSubview(otpFieldView)
        mobileNumberTxtfld.removeFromSuperview()
        otpFieldView.removeFromSuperview()
        stackView.addArrangedSubview(newPassword)
        stackView.addArrangedSubview(confirmPassword)
    }
    
    func disableResendStackView(){
        resendBtn.isHidden = true
        resendBtn.isEnabled = false
        resendStackViewheightAnchor?.constant = 0
    }
    
    func enableResendStackView(){
        resendBtn.isHidden = false
        resendStackViewheightAnchor?.constant = 50
    }
    
    func scheduledTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(didStartTimer), userInfo: nil, repeats: true)
    }
}


