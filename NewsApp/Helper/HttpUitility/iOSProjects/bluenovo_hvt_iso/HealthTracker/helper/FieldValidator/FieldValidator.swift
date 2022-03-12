//
//  FieldValidator.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 27/07/21.
//

import Foundation

class FieldValidator {
    
    static let sharedInstance = FieldValidator()
    
    func validateEmailFormat(_ text : String)->Bool{
       
        let laxString = ".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
        let emailRegex = laxString;
        let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex);
        return emailTest.evaluate(with: text);
    }
    
    func validateNumberString(_ text : String)->Bool{
        
        let regEx = "^[0-9]+$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let success = predicate.evaluate(with: text)
        return success
    }
    
    func validatePlainString(_ text : String)->Bool{
        
        let regEx = "^[a-zA-Z ]+$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        let success = predicate.evaluate(with: text)
        return success
    }
    
    func validateYouTubeUrl(_ text : String)->Bool{
        
        let laxString = "^(http(s)??\\:\\/\\/)?(www\\.)?(((m.)youtube\\.com\\/watch\\?v=)|(youtu.be\\/))([a-zA-Z0-9\\-_])+"
        let youTubeRegix = laxString;
        let emailTest:NSPredicate = NSPredicate(format:"SELF MATCHES %@", youTubeRegix)
        return emailTest.evaluate(with: text)        
    }
    
    func validatePhone(_ text : String)->Bool {
        
        if text.replacingOccurrences(of: " ", with: "") == ""{

            return false
        }
        else  if text.count < 8 || text.count ?? 0 > 15{
            
            return false
        }
    
        return true
    }
    
}
