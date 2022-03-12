//
//  FetureAppointmentsService.swift
//  HealthTracker
//
//  Created by Abhishek Dhiman on 29/11/21.
//

import Foundation

class FutureAppointmentsService : NSObject {
    
    let TAG = "FetureAppointmentsService"
    
    func getAppointmentsData(with request: FutureAppointmentsRequest ,completionHandler : @escaping ((FutureAppointmentsResponse?)->())){
        
        let url = AppConnectionConfig.webServiceURL + "/appointmentsByDate"
        
        guard let urlRequest = request.convertToQueryStringUrl(urlString: url) else {
            
            return
        }
        Log.echo(key: TAG, text: urlRequest)
        
        guard let token = SignedUserInfo.sharedInstance?.token else {
            return
        }
        Log.echo(key: TAG, text: token)
        
        let requestUrl = HURequest(withUrl: urlRequest, forHttpMethod: .get)
        var uttility = HttpUtility.shared
        uttility.authenticationToken = "Bearer " + token
        
        uttility.request(huRequest: requestUrl, resultType: FutureAppointmentsResponse.self) { response in
            
            switch response{
            case .success(let result):
                Log.echo(key: self.TAG, text: result)
                completionHandler(result)
                
            case .failure(let error):
                Log.echo(key: self.TAG, text: error.serverResponse)
                
            }
        }
    }
}
