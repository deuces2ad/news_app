//
//  CancelService.swift
//  HealthTracker
//
//  Created by Apple on 18/10/21.
//

import Foundation

class CancelService : NSObject {
    
    let TAG = "CancelService"
    
    func updateInfo(for appiontmentRequest : CancelRequest, completionHandler : @escaping ((CancelServiceResponse?)->Void)){
        
        let url = AppConnectionConfig.webServiceURL + "/cancelAppointment"
        
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
        
        uttility.request(huRequest: urlRequest, resultType: CancelServiceResponse.self) { response in
            
            switch  response {
            case .success(let response):
                Log.echo(key: "status updated!", text: response)
                _ = completionHandler(response)
                
            case .failure(_): break
                //
            }
            
        }
    }
}

struct CancelServiceResponse: Decodable {
    var success: Bool?
    var data, message: String?
}
