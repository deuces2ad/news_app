//
//  SignedUserInfo.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation

class SignedUserInfo: UserInfo , NSCoding {
    

    var accessToken: String?
    var notificationCount: Int?
    
    private static var _sharedInstance : SignedUserInfo?
    
    static let encodingKey = "userInfo"
    
    static var sharedInstance: SignedUserInfo?{
        get {
            if _sharedInstance != nil{
                return _sharedInstance
            }
            let instance = retreiveInstance()
            _sharedInstance = instance
            return instance
        }
    }
    
    static func initSharedInstance(userInfo : LoginResponse?)->SignedUserInfo{
        
        let oldInstance = sharedInstance
        let info = SignedUserInfo(userInfo: userInfo)
        _sharedInstance = info
        //        info.save()
        info.accessToken = oldInstance?.accessToken
        return info
    }
    
    override init(){
        super.init()
    }
    
    override init(userInfo  : LoginResponse?){
        super.init(userInfo: userInfo!)
    }
    
    override func fillInfo(info : LoginResponse?){
        super.fillInfo(info: info)
        save()
    }
    
    func save(){
        
        let ud = UserDefaults.standard
        let instance = self
        //        SignedUserInfo._sharedInstance = instance
        let data = NSKeyedArchiver.archivedData(withRootObject: instance)
        ud.set(data, forKey: SignedUserInfo.encodingKey)
        ud.synchronize()
    }
    
    private static func retreiveInstance()->SignedUserInfo?{
        
        let ud = UserDefaults.standard
        guard let data = ud.object(forKey: encodingKey) as? Data
        else{
            return nil
        }
        let unarc = NSKeyedUnarchiver(forReadingWith: data)
        unarc.setClass(SignedUserInfo.self, forClassName: "SignedUserInfo")
        let signedUserInfo = unarc.decodeObject(forKey: "root") as? SignedUserInfo
        return signedUserInfo
    }
    
    required convenience init(coder aDecoder: NSCoder){
        self.init()
        
        token = aDecoder.decodeObject(forKey: "token") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        address = aDecoder.decodeObject(forKey: "address") as? String
        state = aDecoder.decodeObject(forKey: "state") as? String
        zipcode = aDecoder.decodeObject(forKey: "zipcode") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        preferredLanguage = aDecoder.decodeObject(forKey: "preferredLanguage") as? String
        notes = aDecoder.decodeObject(forKey: "notes") as? String
        gender = aDecoder.decodeObject(forKey: "gender") as? String
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(zipcode, forKey: "zipcode")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(preferredLanguage, forKey: "preferredLanguage")
        aCoder.encode(notes, forKey: "notes")
        aCoder.encode(gender, forKey: "gender")
    }
    
    func clear(){
        
        let ud = UserDefaults.standard
        ud.set(nil, forKey: SignedUserInfo.encodingKey)
        ud.synchronize()
        notificationCount = 0
        SignedUserInfo._sharedInstance = nil
    }
    
}
