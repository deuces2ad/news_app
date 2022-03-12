//
//  ResetPasswordService.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 25/11/21.
//

import Foundation

class ResetPasswordService : NSObject {
    
    let TAG = "ResetPasswordService"
    
    func resetPasswordWith(from oldPassword : ResetPasswordRequest,completionHandler :@escaping ((_ repponse : ForgotPasswordResponse?)->())){
        
        let url = AppConnectionConfig.webServiceURL + "/resetPassword"
        
        guard let requesturl = oldPassword.convertToQueryStringUrl(urlString: url) else {
            Log.echo(key: TAG, text: "REQUEST URL NOT FOUNDDDD!!!!")
            return
        }
        
        let request = HURequest(withUrl: requesturl, forHttpMethod: .post)
        
        var utility = HttpUtility.shared
        
        utility.request(huRequest: request, resultType: ForgotPasswordResponse.self) { (result) in
            
            switch result {
            case .success(let data) :
                Log.echo(key: self.TAG, text: data)
                completionHandler(data)
                
            case .failure(let error) :
                Log.echo(key: self.TAG, text: error.serverResponse)
            }
        }
    }
}
