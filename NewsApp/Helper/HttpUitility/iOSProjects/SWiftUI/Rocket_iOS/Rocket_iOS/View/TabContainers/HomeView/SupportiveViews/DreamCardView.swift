//
//  DreamCardView.swift
//  Rocket_iOS
//
//  Created by Abhishek Dhiman on 31/12/21.
//

import SwiftUI

struct DreamCardView: View {
    
     // MARK: - PROPERTIES
    let TAG = "DreamCardView"
    var dreamName : String = "Hosuse Renvo"
    
    var  totalbalence : Int = 0
    var yeildPercentage : Int = 0
    
    var screenSize : CGSize
    
    var containerSize : CGFloat{
        return UIDevice.isIPad ?
        screenSize.width * 0.45
        :
        UIDevice.hasNotch ? screenSize.width * 0.67 : screenSize.width * 0.67
    }
    
    var fontSize : CGFloat{
        return UIDevice.isIPad ? 21 : 14
    }
    
    // MARK: - BODY
    var body: some View {
        
        
        let formatedtotalBalence : String = "Rp " + "\(self.totalbalence)"
        let formatedYildPercentage : String = "Rp " + "\(self.totalbalence)" + " (\(self.yeildPercentage)%)"
        
        
        ZStack{
            
            VStack(alignment: .leading, spacing: 15){
                
                HStack(spacing: 10) {
                    
                    //Dream image...
                    
                    Image("house")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                        .background(AppThemeConfig.themeLightYellowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                    
                    VStack(alignment: .leading, spacing: 0){
                        
                        HStack(spacing: 0){
                            
                            //Dream Name.....
                            
                            Text("Dream Name")
                                .foregroundColor(AppThemeConfig.themeGrayColor)
                                .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                            
                            Spacer()
                            
                            //Edit button....
                            
                            Button(action: {}) {
                                Image("pencil")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(AppThemeConfig.orangeColor)
                                
                            }
                        }
                        .frame(maxWidth:.infinity)
                        
                        //Dream Name....
                        Text(dreamName)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize + 2))
                        
                    }//VSTACK
                }
                
                
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 0){
                        
                        Text("Total Amount")
                            .foregroundColor(AppThemeConfig.themeGrayColor)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                        
                        Text(formatedtotalBalence)
                            .foregroundColor(AppThemeConfig.themeGrayColor)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize + 4))

                    }
                   
                    //Circular Percentage Bar...
                    ZStack{
                        CircularProgressBar(screenSize: screenSize)
                    }
                        .frame(maxWidth:.infinity,alignment: .trailing)
                 
                   
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Total Yeild")
                        .foregroundColor(AppThemeConfig.themeGrayColor)
                        .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize))
                    
                    HStack{
                        Image("arrowtriangle.up.fill")
                            .renderingMode(.template)
                            .foregroundColor(AppThemeConfig.themeGrayColor)
                        
                        Text(formatedYildPercentage)
                            .foregroundColor(AppThemeConfig.themeGrayColor)
                            .font(Font.custom(AppThemeConfig.AvenirFont, size: fontSize + 4))

                    }
                    
                }
                
                HStack {
                    Spacer()
                    CustomButton(title: "Top up", verticlePadding: 8, backgroundColor: AppThemeConfig.themeYellowColor) {
                        //
                        Log.echo(key: TAG, text: "Top up tapped..!!!")
                    }
                    .frame(width: screenSize.width * 0.30)
                    .padding(.bottom,5)
                    Spacer()
                }
                
                
            }//VSTACK
            
            
            .padding([.top,.leading,.trailing,.bottom],15)
            .frame(width: containerSize,height:containerSize)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.4), radius: 3, x: 2, y: 4)
//            .padding()
        }//ZSTACK
    }
}

struct DreamCardView_Previews: PreviewProvider {
    static var previews: some View {
        DreamCardView(screenSize: UIScreen.main.bounds.size)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


