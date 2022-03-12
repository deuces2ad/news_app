//
//  EmailSigninManager.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 02/08/21.
//

import Foundation

class EmailSigninService: NSObject {
    
    let TAG = "EmailSigninService"
    
    func loginWithEmail(with loginRequest: EmailLoginRequest, completionHandler: @escaping((_ result: LoginResponse?)->Void)){
        
        let url = AppConnectionConfig.webServiceURL + "/login"
        
        guard let requestUrl = loginRequest.convertToQueryStringUrl(urlString: url) else{
            return
        }
        
        Log.echo(key: TAG, text: "\(requestUrl)")
        
        let request =  HURequest.init(withUrl: requestUrl, forHttpMethod: .post)
        
        
        HttpUtility.shared.request(huRequest: request, resultType: LoginResponse.self) { response in
        
            switch  response {
            case .success(let loginResponse):
                Log.echo(key: "LOGIN RESPONSE RESULT", text: "\(response)")
            _ = completionHandler(loginResponse)
                
            case .failure(_): break
                //
            }
        }
    }
}
