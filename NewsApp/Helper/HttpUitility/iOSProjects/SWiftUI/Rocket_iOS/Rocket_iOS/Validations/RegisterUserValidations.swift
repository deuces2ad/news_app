//
//  RegisterUserValidations.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 20/12/21.
//

import Foundation


struct RegisterUserValidations {
    
    func validateUserInputs(userName : String , userPhoneNumber : String , friendReferal : String?) -> ValidationResult{
        
        if (userName.isEmpty || userPhoneNumber.isEmpty){
            return ValidationResult(success: false, errorMessage: "Name and phone number can't left empty.")
        }
        
        if (isValidUserName(Input: userName) == false){
            return ValidationResult(success: false, errorMessage: "Please enter user name")
        }
        
        if (validatePhoneNumber(value: userPhoneNumber) == false){
            return ValidationResult(success: false, errorMessage: "Please enter valid phone number")
        }
        
        return ValidationResult(success: true, errorMessage: nil)
    }
    
    // valid user name..
    private func isValidUserName(Input:String) -> Bool {
        return Input.range(of: "\\A\\w{7,18}\\z", options: .regularExpression) != nil
    }
    
    // valid phone number.
    private func validatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}
