//
//  ItemView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 29/12/21.
//

import SwiftUI

struct ItemView: View {
    
     // MARK: - PROPERTIES
    
    var imageName: String
    var discription: String
    var bGcolor : Color
    
    var imagePercentace : CGFloat{
        return UIDevice.isIPad ? 1.65 : 1.9
    }
    
    var fontSize : CGFloat{
        return UIDevice.isIPad ? 25 : 19
    }
    
     // MARK: - BODY
    
    var body: some View {
       
        ZStack {
            bGcolor
            VStack{
                Image(imageName)
                    .resizable()
//                    .background(Color.red)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRect().width,
                           height: getRect().height / imagePercentace)
                    .padding(.top,44)
                
                Spacer()
                
                Text(discription)
                    .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                    .padding()
                    .foregroundColor(bGcolor == AppThemeConfig.orangeColor ? Color.white : Color.black)
                    .frame(alignment: .top)
                    .multilineTextAlignment(.center)
                    .frame(height:200)
            
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(imageName: "1", discription: "Cari uang tambahan dengan cara yang asik! Luncurkan Rocketmu sekarang!", bGcolor: Color.orange)
            .previewDevice(DeviceList.iPhone8)
        ItemView(imageName: "1", discription: "Cari uang tambahan dengan cara yang asik! Luncurkan Rocketmu sekarang!", bGcolor: Color.white)
            .previewDevice(DeviceList.iPhone13)
        ItemView(imageName: "1", discription: "Cari uang tambahan dengan cara yang asik! Luncurkan Rocketmu sekarang!", bGcolor: Color.white)
            .previewDevice(DeviceList.iPadMini6ThGeneration)
    }
}
