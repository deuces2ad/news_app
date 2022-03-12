//
//  LoginViewModel.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 20/12/21.
//

import Foundation

struct LoginDataModel {
    
    var userEmail : String = "Test@gmail.com"
    var userPassword : String = "Gz123456"
    var userConfirmPassword : String = "Gz123456"
    var userNameAsPerIdCard : String = "Test_User"
    var userPhnNumber : String =  "+62 8234373893"
    var userReferalCode : String = "GRZ23021"
    var isRegisterdUser : Bool = false
    var errorMessage : String = "String()"
    var isPresentingErrorAlert: Bool = false
    var registerUser: Bool = false
    var re_Enter_Password: String = ""
    var showReEnterPassword: Bool = false
}


class LoginViewModel : ObservableObject{
    
     // MARK: - Properties
    @Published var  loginDataModel : LoginDataModel = LoginDataModel()
    let loginValidation : LoginValidation = LoginValidation()
    let signupValidation : SignupValidation = SignupValidation()
    let registerUserValidation : RegisterUserValidations = RegisterUserValidations()
    
    @AppStorageCompat("log_Status") var log_Status: Bool = false
    
     // MARK: - Validations Check...
    
  
    func validateUserInputsForLogin() -> Bool{
        
        let results = loginValidation.validateUserInputs(userEmail: loginDataModel.userEmail, userPassword: loginDataModel.userPassword)
        
        if (results.success == false){
            loginDataModel.errorMessage = results.errorMessage ?? "Something went wrong..!!"
            loginDataModel.isPresentingErrorAlert = true
            return false
        }
        return true
    }
    
    // Validatidate user inputs on Signup...
    
    func validateUserInputsForSignup() -> Bool {
        let result = signupValidation.validateUserInput(userEmail: loginDataModel.userEmail, userPassword: loginDataModel.userPassword, userConfirmPassword: loginDataModel.userConfirmPassword)
        
        if (result.success == false){
            
            loginDataModel.errorMessage = result.errorMessage ??  "Something went wrong..!!"
            loginDataModel.isPresentingErrorAlert = true
            return false
        }
        
        return true
    }
    // Validatidate user inputs on final steps...
    
    func validateUserInputForFinalStep() -> Bool{
        let result = registerUserValidation.validateUserInputs(userName: loginDataModel.userNameAsPerIdCard, userPhoneNumber: loginDataModel.userPhnNumber, friendReferal: nil)
        
        if (result.success == false){
            
            loginDataModel.errorMessage = result.errorMessage ?? "Something went wrong..!!"
            loginDataModel.isPresentingErrorAlert = true
            return false
        }
        
        return true
    }

    
     // MARK: - API Service calls...
    
    /// Login API
    
    func authenticateService(){
        log_Status = true
    }
    
    /// register API
    
    func registerUserService(){
        
    }
    
    
}
