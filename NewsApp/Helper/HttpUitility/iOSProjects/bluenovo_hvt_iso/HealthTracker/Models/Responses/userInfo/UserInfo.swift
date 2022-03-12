//
//  UserInfo.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//
//


//Patient:
//email: hvtpatient1@yopmail.com
//password: Hvtpatient1#123

//Staff:
//email: hvtstaff1@yopmail.com
//password: Hvtstaff1#123

import Foundation

class UserInfo: NSObject {
    
    
    enum roleType : String {
        case doctor = "Doctor"
        case patient = "Patient"
    }
    
    enum genderType : String{
        case male = "Male"
        case femaale = "Female"
    }
    
    
    public  func role(withRoleId role: String?)-> roleType{
        let roleId = role ?? ""
        
        
        switch roleId {
        case "Doctor":
            return .doctor
        default:
            return .patient
        }
    }
    
    
    var token: String?
    var email: String?
    var name: String?
    var userRole : String?
    var phone: String?
    var address : String?
    var state : String?
    var zipcode: String?
    var image : String?
    var dob : Int?
    var gender : String?
    var preferredLanguage : String?
    var notes : String?
    var city : String?
    var licenseNumber : String?

    
    override init(){
        super.init()
    }
    
    init(userInfo : LoginResponse) {
        super.init()
        fillInfo(info: userInfo)
    }
    
    var role : roleType{
        get{
            return self.role(withRoleId: self.userRole)
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
        phone = info.phone
        address = info.address
        state = info.state
        zipcode = info.zipcode
        image = info.image
        dob = info.dob
        gender = info.gender
        preferredLanguage = info.preferredLanguage
        notes = info.notes
        userRole  = info.role
        city = info.city
        licenseNumber = info.licenseNumber
    }
}
