//
//  EmitLiveLocation.swift
//  HealthTracker
//
//  Created by Grazitti on 22/09/21.
//

import Foundation
import UIKit
import CoreLocation

class EmitLiveLocation: NSObject{
    
    let TAG = "AppointmentsDetail"
    
    func shareLiveLocation(with location: LocationEmiterRequest,completionHandler:@escaping (()->Void)){
    
        let urlString = AppConnectionConfig.webServiceURL + "/location"
        
        guard let requestUrl = location.convertToQueryStringUrl(urlString: urlString) else {
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
        
        uttility.request(huRequest: urlRequest, resultType: Welcome.self) { response in
        
            switch  response {
            case .success(let response):
                Log.echo(key: "Location sent successfully!", text: response)
            _ = completionHandler()
                
            case .failure(_): break
                //
            }
        }
    }
}
