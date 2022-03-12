//
//  ForgetPasswordService.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 24/11/21.
//

import Foundation

class ForgetPasswordService : NSObject{
    
    let TAG = "ForgetPasswordService"
    
    func requestOTP(with mobileNumber: ForgotPasswordRequest, completionHandler : @escaping (_ response : ForgotPasswordResponse?)->()){
        
         let url = AppConnectionConfig.webServiceURL + "/forgetPassword"
        
        guard let requestUrl = mobileNumber.convertToQueryStringUrl(urlString: url) else{
            Log.echo(key: TAG, text: "no URL request found!!!!!!!")
            return
        }
        
        let urlRequest = HURequest(withUrl: requestUrl, forHttpMethod: .post)
        var uttility = HttpUtility.shared
        
        uttility.request(huRequest: urlRequest, resultType: ForgotPasswordResponse.self) { response in
            
            switch  response{
            case .success(let result):
                Log.echo(key: "status updated!", text: result)
                _ = completionHandler(result)
                
            case .failure(let error):
                Log.echo(key: self.TAG, text: error.serverResponse)
            }
        }
         
    }
}
