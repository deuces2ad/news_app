//
//  ForgotPasswordController.swift
//  HealthTracker
//
//  Created by Apple on 22/11/21.
//

import Foundation
import UIKit

class ForgotPasswordController : InterfaceExtendedController{
    
    let TAG = "ForgotPasswordController"
    var mobileNumber : String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVarible()
        registerListners()
    }

    func initializeVarible(){
        paintInterface()
        rootView.controller = self
    }
    //MARK: - Set RootView
    lazy var rootView : ForgotPasswordRootView = {
        let rootView = ForgotPasswordRootView()
        return rootView
    }()
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    func paintInterface(){
        paintNavigationTitle(text: "Reset Password")
        paintBackButton()
    }
    
    func registerListners(){
        resetBtnListner()
    }

    
    func resetBtnListner(){
        self.rootView.discriptionTxtLbl.text = ""
        rootView.resetBtnListner = { currentStatus in
            switch currentStatus {
            case .next:
                Log.echo(key: self.TAG, text: "NEXT Button Tapped")
                if self.rootView.mobileNumberTxtfld.infoTxtField.text?.isEmpty ?? false{
                    self.showToastMessage(with: "Please your register Mobile Number.")
                    return
                }
                DispatchQueue.main.async {
                    self.requestOTPService()
                }
               
                
            case .verify :
                Log.echo(key: self.TAG, text: "reset Button Tapped")
                self.verifyServices()
                
            case .reset:
                Log.echo(key: self.TAG, text: "reset Button Tapped")
                self.resetPasswordService()
            }
        }
    }
    
    //MARK: - API Services
    func requestOTPService(){
        self.mobileNumber = self.rootView.mobileNumberTxtfld.infoTxtField.text?.cleanPhoneNumber()
        let request = ForgotPasswordRequest(phone: mobileNumber)
        self.showLoader()
        ForgetPasswordService().requestOTP(with: request) { response in
            self.stopLoader()
            if response != nil{
                
                Log.echo(key: "API REESPONSE", text: response)
                
                if response?.success ?? false{
                    DispatchQueue.main.async {
                        self.stopLoader()
                        self.rootView.currentStatus = .verify
                        self.rootView.enableOTPfield()
                        self.rootView.enableResendStackView()
                        self.rootView.resetBtn.setTitle(self.rootView.currentStatus.rawValue, for: .normal)
                        self.rootView.scheduledTimer()
                        self.rootView.discriptionTxtLbl.text = "OTP is sent to your registered Mobile Number"
                        self.rootView.discriptionTxtLbl.textColor = AppThemeConfig.LightGreen
                    }
                }else{
                    DispatchQueue.main.async {
                        self.stopLoader()
                        let message = response?.data?[0] ?? response?.message
                        self.rootView.discriptionTxtLbl.textColor = .red
                        self.rootView.discriptionTxtLbl.text = message
                    }

                }
            }
        }
    }
    
    func verifyServices(){
        let mobileNumber = self.rootView.mobileNumberTxtfld.infoTxtField.text?.cleanPhoneNumber()
        let enterOtp = self.rootView.otpFieldView.infoTxtField.text
        self.showLoader()
        let request = ForgotPasswordRequest(phone: mobileNumber,token: enterOtp)
        VerifyTokenService().verifyToken(with: request) { response in
            DispatchQueue.main.async {
                if response != nil{
                    self.stopLoader()
                    self.rootView.resendStackView.isHidden = true
                    if response?.success ?? false{
                        Log.echo(key: "API REESPONSE", text: response)
                        self.rootView.disableMobile_OTPfied()
                        self.rootView.currentStatus = .reset
                        self.rootView.discriptionTxtLbl.text = "Please enter your new password"
                        self.rootView.discriptionTxtLbl.textColor = .gray
                        self.rootView.resetBtn.setTitle(self.rootView.currentStatus.rawValue, for: .normal)
                    }else{
                        self.stopLoader()
                        let message = response?.data?[0] ?? response?.message
                        self.rootView.discriptionTxtLbl.textColor = .red
                        self.rootView.discriptionTxtLbl.text = message
                    }
                }
            }
        }
    }
        
        func resetPasswordService(){
            showLoader()
            let newpassword = rootView.newPassword.infoTxtField.text
            let confirmPassoword = rootView.newPassword.infoTxtField.text
            
            guard let mobileNumber = self.mobileNumber else{
                Log.echo(key: TAG, text: "Mobile nUmber didn't find")
                return
            }
            let requestParameters = ResetPasswordRequest(phone:mobileNumber, password: newpassword, password_confirmation: confirmPassoword)
            
            
            if rootView.newPassword.infoTxtField.text != rootView.confirmPassword.infoTxtField.text{
                DispatchQueue.main.async {
                    self.stopLoader()
                    self.rootView.discriptionTxtLbl.text = "Password didn't mathch."
                }
                return
            }
            ResetPasswordService().resetPasswordWith(from: requestParameters) { response in
                self.stopLoader()
                
                if response?.success ?? false{
                    DispatchQueue.main.async {
                        RootControllerManager().getTopRootController()?.alert(withTitle: AppInfoConfig.appName, message: response?.message ?? "", successTitle: "Login Now", rejectTitle: "", showCancel: false) { success in
                            if success{
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.stopLoader()
                        let message = response?.data?.joined(separator: "")
                        let modifiedTxt = message?.replacingOccurrences(of: ".", with: "\n")
                        self.rootView.discriptionTxtLbl.textColor = .red
                        self.rootView.discriptionTxtLbl.text = modifiedTxt
                    }
                }
            }
        }
    }


//MARK: - Text field Delegate

extension ForgotPasswordController : UITextFieldDelegate{
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            rootView.scrollView.activeField = textField
            return true
        }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == rootView.otpFieldView.infoTxtField{
            let charsLimit = 6
            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            return newLength <= charsLimit
        }
        
        if textField == rootView.mobileNumberTxtfld.infoTxtField{
            let charsLimit = 15

            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            rootView.mobileNumberTxtfld.infoTxtField.text = textField.text?.formatMobileNumber()
            return newLength <= charsLimit
        }
       return true
    }
}
