//
//  KVCInitiatedDashBoardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 28/12/21.
//

import SwiftUI


struct KYCInitiatedDashBoardView: View {
    
     // MARK: - PROPERTIES
    
    let TAG = "KVCInitiatedDashBoardView"
    var showUserProfileTab : Bool = true
    
    var fontSize : CGFloat {
        return UIDevice.isIPad ? 25 : 16
    }

    
     // MARK: - BODY
    
    var body: some View {
        
        GeometryReader { proxy in
            
            let size = proxy.size
            
            BackgroundImage(screenSize: size, imageName: "homeBg", contentMode: .fit,backgroundColor: AppThemeConfig.themeLightYellowColor)
                .frame(height: size.height * 0.65,alignment: .topLeading)
                .edgesIgnoringSafeArea(.top)

        }
}

struct KVCInitiatedDashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            
            KYCInitiatedDashBoardView()
                .previewDevice(DeviceList.iPhone8)
            KYCInitiatedDashBoardView()
                .previewDevice(DeviceList.iPhone13)
            KYCInitiatedDashBoardView()
                .previewDevice(DeviceList.iPadMini6ThGeneration)
            
           
            
        }
       
        

    }
}


}
