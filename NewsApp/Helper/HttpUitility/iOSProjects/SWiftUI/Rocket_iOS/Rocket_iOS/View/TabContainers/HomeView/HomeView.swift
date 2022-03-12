//
//  HomeView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 18/12/21.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - PROPERTIES
    
    @State var containedViewType: UserType = .KYCOnProgress
    let TAG = "HomeView"
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            containedView()
                .navigationBarHidden(true)
        }
        .navigationBarTitle("") //this must be empty
         .navigationBarHidden(true)
         .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - GET_CURRENT_VIEW
    
    func containedView() -> AnyView {
        
        switch containedViewType {
            
        case .NotRegisteredUser:
            return AnyView(NotRegisteredUserDashBoardView())
            
        case .RegisteredNoKYC:
            return AnyView(RegisteredNoKYCDashBoardView())
            
        case .KYCOnProgress:
            return AnyView(KYCOnProgressDashBoardView())
            
        case .KYCApproved:
            return AnyView(KYCApprovedDashBoardView())
        }
    }
}
// MARK: - HOME_VIEW_PREVIEW

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice(DeviceList.iPhone8)
        HomeView()
            .previewDevice(DeviceList.iPhone13)
        HomeView()
            .previewDevice(DeviceList.iPadMini6ThGeneration)
    }
}

