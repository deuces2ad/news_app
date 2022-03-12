//
//  EnrouteStatusService.swift
//  HealthTracker
//
//  Created by Apple on 07/10/21.
//

import Foundation


class EnrouteStatusService : NSObject {
    
    let TAG = "EnrouteStatusService"
    
    func updateInfo(for appiontmentRequest : EnrouteStatusRequest, completionHandler : @escaping ((EnrouteResponse?)->Void)){
        
        let url = AppConnectionConfig.webServiceURL + "/changeStatus"
        
        guard let requestUrl = appiontmentRequest.convertToQueryStringUrl(urlString: url) else {
            return
        }
        
        Log.echo(key: TAG, text: "request : \(requestUrl)")
        guard let token = SignedUserInfo.sharedInstance?.token else {
            Log.echo(key: TAG, text: "No token found!!!")
            return
        }
        let basicToken = "Bearer " + token
        Log.echo(key: TAG, text: " token is : \(token)")
        
        let urlRequest = HURequest(withUrl: requestUrl, forHttpMethod: .post)
        var uttility = HttpUtility.shared
        uttility.authenticationToken = basicToken
        
        uttility.request(huRequest: urlRequest, resultType: EnrouteResponse.self) { response in
            
            switch  response {
            case .success(let response):
                Log.echo(key:self.TAG, text: response)
                _ = completionHandler(response)
                
            case .failure(let error):
                
                
                Log.echo(key: self.TAG, text: "\(error.serverResponse)")
                
                _ = completionHandler(nil)
                
            }
            
        }
        
    }
}

// MARK: - Welcome

struct EnrouteResponse: Decodable {
    var success: Bool?
    var data: Enroutedata?
    var message: String?
}

// MARK: - DataClass
struct Enroutedata: Decodable {
    var message: String?
}
