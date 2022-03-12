//
//  LoginValidations.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 20/12/21.
//

import Foundation

struct ValidationResult {
    var success: Bool = false
    var errorMessage: String?
}


struct LoginValidation {

     // MARK: - Login Validation..
    
    func validateUserInputs(userEmail: String , userPassword: String) -> ValidationResult {

        if(userEmail.isEmpty || userPassword.isEmpty){
            return ValidationResult(success: false, errorMessage: "User email and password cannot be empty")
        }
        if(isValidEmail(value: userEmail) == false){
            return ValidationResult(success: false, errorMessage: "User email format is incorrect")
        }
        
//        if (isValidPassword(value: userPassword) == false){
//            return ValidationResult(success: false, errorMessage: "Password must be more than 6 characters, with at least one capital, numeric or special character")
//        }

        return ValidationResult(success: true, errorMessage: nil)
    }
    
    
    // MARK: - Signup Validation..

    
    // validate the password
    private func isValidPassword(value:String) -> Bool
    {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{6,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: value)
        
    }


    // validate the email id
    private func isValidEmail(value: String) -> Bool
    {
        let regex = try! NSRegularExpression(pattern: "(^[0-9a-zA-Z]([-\\.\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,64}$)", options: .caseInsensitive)
        return regex.firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) != nil
    }
}
