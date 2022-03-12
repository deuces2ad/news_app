//
//  NSString+ Extension.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 01/09/21.
//

import Foundation

let LanguageKey = "LanguageKey"

extension String {
    func localized() -> String? {
        
        //abhishek : for staff no translation is required.
        if let role = SignedUserInfo.sharedInstance?.role  {
            if role == .doctor{
                return self
            }
        }
    
        
        var defaultLanguage = "en"
        
        if let selectedLanguage = UserDefaults.standard.string(forKey: LanguageKey){
            defaultLanguage = selectedLanguage
            return NSLocalizedString(self, tableName: defaultLanguage, comment: "")
        }else{
            return NSLocalizedString(
                self,
                tableName: "Localizable",
                bundle: .main,
                value: self,
                comment: self)
        }
    }
}
