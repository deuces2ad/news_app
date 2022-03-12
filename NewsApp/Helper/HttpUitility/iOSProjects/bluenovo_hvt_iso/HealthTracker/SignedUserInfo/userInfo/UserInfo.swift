//
//  UserInfo.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation

class UserInfo: NSObject {
    
    
    enum roleType : String {
        case patient = "Patient"
        case staff = "Staff"
    }
    
    enum genderType : String{
        case male = "Male"
        case femaale = "Female"
    }
    
    
    public  func role(withRoleId role: String?)-> roleType{
        let roleId = role ?? ""
        
        
        switch roleId {
        case "Patient":
            return .patient
        default:
            return .staff
        }
    }
    
    
    var token: String?
    var email: String?
    var name: String?
    var roleType : String?
    var phone: String?
    var address : String?
    var state : String?
    var zipcode: String?
    var image : String?
    var dob : String?
    var gender : String?
    var preferredLanguage : String?
    var notes : String?

    
    override init(){
        super.init()
    }
    
    init(userInfo : LoginResponse) {
        super.init()
        fillInfo(info: userInfo)
    }
    
    var role : roleType{
        get{
            return self.role(withRoleId: self.roleType)
        }
    }
    
    var genderType : genderType{
        get{
            if (gender == "Male") {
                return .male
            }else{
                return .femaale
            }
        }
    }
    
     func fillInfo(info : LoginResponse?){
        
        guard let info = info?.data else{
            return
        }
        
        token = info.token
        email = info.email
        name = info.name
        phone = "\(info.phone)"
        address = info.address
        state = info.state
        zipcode = info.zipcode
        image = info.image
        dob = info.dob
        gender = info.gender
        preferredLanguage = info.preferredLanguage
        notes = info.notes
        gender = info.gender
        
    }
}
