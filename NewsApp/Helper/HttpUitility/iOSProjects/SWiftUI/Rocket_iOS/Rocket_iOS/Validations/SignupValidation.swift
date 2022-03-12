//
//  SignupValidation.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 20/12/21.
//

import Foundation



struct SignupValidation {
    
    func validateUserInput(userEmail : String, userPassword : String , userConfirmPassword : String) -> ValidationResult{
        
        if (userEmail.isEmpty || userPassword.isEmpty || userConfirmPassword.isEmpty){
            return ValidationResult(success: false, errorMessage: "Email,Password or Confirm passoword can't be left empty.")
        }
        
        if (isValidEmail(value: userEmail) == false){
            return ValidationResult(success: false, errorMessage: "Please enter valid email address.")
        }
        
        if (userPassword != userConfirmPassword){
            return ValidationResult(success: false, errorMessage: "Confirm password didn't match")
        }
        
        return ValidationResult(success: true, errorMessage: nil)
    }
    
    // validate the email id
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
}

