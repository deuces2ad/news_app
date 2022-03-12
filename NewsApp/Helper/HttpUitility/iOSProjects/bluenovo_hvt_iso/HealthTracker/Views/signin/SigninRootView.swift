//
//  SigninRootView.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//
//

import UIKit



class SigninRootView: ExtendedView {
    
    var controller : SigninController?
    let TAG = "SigninRootView"
    
    @IBOutlet fileprivate var emailField : SigninFieldView?
    @IBOutlet fileprivate var passwordField : SigninFieldView?
    @IBOutlet fileprivate var errorLabel : UILabel?
    
    @IBOutlet fileprivate var scrollView : FieldManagingScrollView?
    @IBOutlet fileprivate var scrollContentBottomOffset : NSLayoutConstraint?
    
    @IBOutlet fileprivate var signUpView:Signupview?
    
    @IBOutlet fileprivate var signInView:UIView?
    @IBOutlet fileprivate var facebookView:UIView?
    @IBOutlet weak var loginLbl : UILabel?
    @IBOutlet weak var forgotPassword : UILabel?
    
    @IBAction fileprivate func fbLoginAction(){

            self.resetErrorStatus()
    }
  
  
  @IBAction fileprivate func appleLoginAction(){
    
    Log.echo(key: "dhi", text: "AppleLogin tapped")
  }
    
    func paintCurveSignInView(){
        
        signInView?.layer.cornerRadius = (UIDevice.current.userInterfaceIdiom == .phone ? 22.5:32.5)
        signInView?.layer.masksToBounds = true
        
        facebookView?.layer.cornerRadius = (UIDevice.current.userInterfaceIdiom == .phone ? 22.5:32.5)
        facebookView?.layer.masksToBounds = true
        loginLbl?.text = "LOGIN".localized() ?? ""
        forgotPassword?.text = "Forgot Password".localized() ?? ""
    }
    
    
    
    @IBAction fileprivate func loginAction(){

        if(validateFields()){
            self.resetErrorStatus()
            DispatchQueue.main.async {
                self.signIn()
            }
        }
    }
    
    @IBAction fileprivate func forgotPasswordAction(sender:UIButton){
        
         let controller = ForgotPasswordController()
        guard let topVc = self.controller?.navigationController else{
            return
        }
        topVc.pushViewController(controller, animated: true)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        initialization()
        
    }
    
    fileprivate func initialization(){
        
        initializeVariable()
    }
    
    fileprivate func initializeVariable(){
        
        emailField?.textField?.attributedPlaceholder = NSAttributedString(string: "Mobile Number".localized() ?? "",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField?.textField?.keyboardType = .numberPad
        
        passwordField?.textField?.attributedPlaceholder = NSAttributedString(string: "Password".localized() ?? "",
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailField?.textField?.delegate = self
        passwordField?.textField?.delegate = self
        scrollView?.bottomContentOffset = scrollContentBottomOffset
        paintCurveSignInView()
    }
}

extension SigninRootView{
    
    func validateFields()->Bool{
        
        let emailValidated  = validateEmail()
        
        
        if !emailValidated{
            return false
        }
        
        let passwordValidated = validatePassword()
        
        if !passwordValidated{
            return false
        }
        return emailValidated && passwordValidated
    }
    
    fileprivate func validateEmail()->Bool{
        
        if(emailField?.textField?.text == ""){
            controller?.showToastMessage(with: "Enter Mobile".localized() ?? "")
            return false
        }
        
        if !(FieldValidator.sharedInstance.validatePhone(emailField?.textField?.text ?? "")){
            controller?.showToastMessage(with: "Please enter a valid phone number!")
            return false
        }
        
        emailField?.resetErrorStatus()
        return true
    }
    
    
    
    
    fileprivate func validatePassword()->Bool{
        
        if(passwordField?.textField?.text == ""){
            
            controller?.showToastMessage(with: "Enter Password".localized() ?? "")
            return false
        }
        passwordField?.resetErrorStatus()
        return true
    }
}

extension SigninRootView : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       
        scrollView?.activeField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField == emailField?.textField){
            
            passwordField?.textField?.becomeFirstResponder()
        }else{
            
            passwordField?.textField?.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailField?.textField{
            let charsLimit = 15

            let startingLength = textField.text?.count ?? 0
            let lengthToAdd = string.count
            let lengthToReplace =  range.length
            let newLength = startingLength + lengthToAdd - lengthToReplace
            emailField?.textField?.text = textField.text?.formatMobileNumber()
            return newLength <= charsLimit
        }

       return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailField?.textField {
            emailField?.textField?.text = textField.text?.formatMobileNumber()
        }
        
    }
}



extension SigninRootView{
    
    fileprivate func signIn(){
        
        let email = emailField?.textField?.text?.cleanPhoneNumber() ?? ""
        let password = passwordField?.textField?.text ?? ""
        
        //Todo: @abhishek : might be in future scope
        
        //        guard let device_token = UserDefaults.standard.value(forKey: "device_token") as? String else{
        //            Log.echo(key: "Error", text: "@device token")
        //            return
        //        }
        
        self.controller?.showLoader()
        
        let loginRequest = EmailLoginRequest(email: email, password: password,device_token: "device_token",device_type: AppInfoConfig.deviceType)
        
        EmailSigninService().loginWithEmail(with: loginRequest) {[weak self] response in
            
            guard let weaSelf = self else{
                Log.echo(key: "abhi", text: "error occured @213")
                return
            }
            guard let rawInfo = response else {
                return
            }
            DispatchQueue.main.async {
                weaSelf.controller?.stopLoader()
                if rawInfo.success == true{
                    let info = SignedUserInfo.initSharedInstance(userInfo: rawInfo)
                    info.accessToken = rawInfo.data?.token
                    info.save()
                    RootControllerManager().updateRoot()
                }else{
                    weaSelf.controller?.stopLoader()
                    weaSelf.controller?.showToastMessage(with: rawInfo.message ?? "error!")
                }
            }
            
        }
    }
    

    func showError(text : String?){
        
        errorLabel?.text = text
    }
    
    func resetErrorStatus(){
        
        errorLabel?.text = ""
        emailField?.resetErrorStatus()
        passwordField?.resetErrorStatus()
    }
}

extension String {

    func formatMobileNumber() -> String {
        
        let cleanPhoneNumber =  components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mark = "XXX-XXX-XXXX"
        
        var result = ""
        var startIndex = cleanPhoneNumber.startIndex
        let endIndex = cleanPhoneNumber.endIndex
        
        
        for char in mark  where startIndex < endIndex{
            if char == "X"{
                result.append(cleanPhoneNumber[startIndex])
                startIndex = cleanPhoneNumber.index(after: startIndex)
            }else{
                result.append(char)
            }
        }
        return result
    }
    
    func cleanPhoneNumber()-> String {
         return replacingOccurrences(of: "-", with: "")
    }
}
